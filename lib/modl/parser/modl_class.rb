module Modl
  module Parser
    # Represents a *class defined, or loaded by, a MODL document.
    class MODLClass
      attr_accessor :id
      attr_accessor :name
      attr_accessor :superclass
      attr_accessor :assign
      attr_accessor :content

      def initialize
        @content = {}
      end

      # Find a keylist of the right length from the *assign array of arrays.
      def keylist_of_length(len)
        return [] if @assign.nil?

        @assign.each do |kl|
          return kl if kl.length == len
        end
        raise InterpreterError,
              'No key list of the correct length in class ' + @id + ' - looking for one of length ' + len.to_s
      end

      def merge_content(new_value)
        @content.each do |k, v|
          new_value[k] = v.extract_hash
        end
        new_value
      end

      def name_or_id
        @name.nil? ? @id : @name
      end
    end

    # Extract a class from a ParsedPair object
    class ClassExtractor
      def self.extract(pair, global)
        return unless pair.type == 'class'

        clazz = MODLClass.new
        map = pair.map if pair.map
        map = pair.valueItem&.value&.map if pair.valueItem&.value&.map

        map.mapItems.each do |item|
          next unless item&.pair&.type

          case item&.pair&.type
          when 'id'
            str_value = item.pair.valueItem.value.string.string
            raise InterpreterError, 'Reserved class id - cannot redefine: ' + str_value if reserved?(str_value)

            clazz.id = str_value
          when 'name'
            str_value = item.pair.valueItem.value.string.string
            raise InterpreterError, 'Reserved class name - cannot redefine: ' + str_value if reserved?(str_value)

            clazz.name = str_value
          when 'superclass'
            str_value = item.pair.valueItem.value.string.string
            clazz.superclass = str_value
          when 'keylist'
            clazz.assign = item.pair.key_lists
          else
            clazz.content[item.pair.key] = item.pair.array if item.pair.array
            clazz.content[item.pair.key] = item.pair.map if item.pair.map
            clazz.content[item.pair.key] = item.pair.valueItem.value if item.pair.valueItem.value
          end
        end

        superclass = clazz.superclass

        if superclass && !reserved?(superclass) && !global.classes.keys.include?(superclass)
          raise InterpreterError, 'Invalid superclass: ' + superclass.to_s
        end
        raise InterpreterError, 'Missing id for class' if clazz.id.nil?

        # Make sure the class name isn't redefining an existing class
        if global.classes[clazz.id].nil? && global.classes[clazz.name].nil?

          # store the classes by id and name to make them easier to find later
          global.classes[clazz.id] = clazz
          global.classes[clazz.name] = clazz
        else
          id = clazz.id.nil? ? 'undefined' : clazz.id
          name = clazz.name.nil? ? 'undefined' : clazz.name
          raise InterpreterError, 'Class name or id already defined - cannot redefine: ' + id + ', ' + name
        end
      end

      # Check for a reserved class name
      def self.reserved?(str)
        %w[map str arr num].include?(str)
      end
    end
  end
end