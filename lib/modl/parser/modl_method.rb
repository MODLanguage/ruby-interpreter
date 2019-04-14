module Modl
  module Parser
    # Represents a *method defined by a MODL document.
    class MODLMethod
      attr_accessor :id
      attr_accessor :name
      attr_accessor :transform

      def name_or_id
        @name.nil? ? @id : @name
      end
    end

    # Extracts a method definition from a ParsedPair
    class MethodExtractor
      def self.extract(pair, global)
        return unless pair.type == 'method'

        mthd = MODLMethod.new
        map = pair.map if pair.map
        map = pair.valueItem&.value&.map if pair.valueItem&.value&.map

        map.mapItems.each do |item|
          next unless item&.pair&.type

          case item&.pair&.type
          when 'id'
            mthd.id = item.pair.valueItem.value.string.string
          when 'transform'
            mthd.transform = item.pair.valueItem.value.string.string
          when 'name'
            mthd.name = item.pair.valueItem.value.string.string
          else
            raise InterpreterError, 'Invalid *method - only *id, *name, and *transform fields expected'
          end
        end

        raise InterpreterError, 'Missing id for method' if mthd.id.nil?
        raise InterpreterError, 'Missing name for method' if mthd.name.nil?
        raise InterpreterError, 'Duplicate method name: ' + mthd.name unless global.methods_hash[mthd.name].nil?
        raise InterpreterError, 'Duplicate method id: ' + mthd.id unless global.methods_hash[mthd.id].nil?

        # store the methods by id and name to make them easier to find later
        global.methods_hash[mthd.id] = mthd
        global.methods_hash[mthd.name] = mthd
      end
    end
  end
end