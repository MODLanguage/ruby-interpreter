module Modl
  module Parser
    # Each time we run the parser on a MODL file we need to keep track of a few things so they can be made available
    # to other areas of the code. This class is the container for that contextual information, which is gathered
    # as the Modl::Parser:Parsed object processes the parse tree.
    class GlobalParseContext

      attr_accessor :syntax_version
      attr_reader :interpreter_syntax_version

      def initialize
        # Holds the index array from a MODL file, e.g. '?=a:b:c:d'
        @index = []
        # Contains all pairs as they are encountered in the parsing process.
        @pairs = {}
        # Contains all defined and loaded classes for the current MODL document.
        @classes_by_id = {}
        @classes_by_name = {}
        # Hold the user-defined methods.
        @methods_hash = {}
        # Tracks the nesting depth for conditional clauses.
        @conditional = 0
        # Defaults to 1 and can be overridden by the *version command.
        @syntax_version = 1
        @interpreter_syntax_version = 1
      end

      def index_value(n, default)
        return default if n > @index.length

        @index[n]
      end

      def in_condition?
        @conditional.positive?
      end

      def enter_condition
        @conditional += 1
      end

      def exit_condition
        @conditional -= 1
      end

      def pair(key, val = nil)
        return @pairs[key] unless val

        @pairs[key] = val
      end

      def classs(key)
        if key.is_a? String
          result = @classes_by_id[key]
          @classes_by_name[key] if result.nil?
        elsif key.is_a? MODLClass
          @classes_by_id[key.id] = key
          @classes_by_name[key.name] = key
        end
      end

      def merge_pairs(other)
        @pairs.merge!(other.all_pairs)
      end

      def merge_classes(other)
        @classes_by_id.merge!(other.all_classes_by_id)
        @classes_by_name.merge!(other.all_classes_by_name)
      end

      def has_pairs?
        @pairs.length.positive?
      end

      def has_class?(key)
        @classes_by_id.keys.include?(key) || @classes_by_name.keys.include?(key)
      end

      def has_user_method?(key)
        @methods_hash.keys.include?(key)
      end

      def add_to_index(item)
        @index << item
      end

      def user_method(key, val = nil)
        return @methods_hash[key] unless val

        @methods_hash[key] = val
      end

      def class_list
        result = Parsed::ParsedArray.new(self)
        @classes_by_id.values.each do |clazz|
          new_item = Parsed::ParsedArrayItem.new(self)
          new_item.arrayValueItem = Parsed::ParsedArrayValueItem.new(self)
          new_item.arrayValueItem.pair = Parsed::ParsedPair.new(self)
          new_item.arrayValueItem.pair.key = clazz.id
          new_item.arrayValueItem.pair.map = to_map(clazz)
          result.abstractArrayItems << new_item
        end
        result
      end

      def method_list
        raise StandardError, 'NOT IMPLEMENTED'
      end

      def file_list
        raise StandardError, 'NOT IMPLEMENTED'
      end

      def id_list
        raise StandardError, 'NOT IMPLEMENTED'
      end

      def name_list
        raise StandardError, 'NOT IMPLEMENTED'
      end

      def superclasse_list
        raise StandardError, 'NOT IMPLEMENTED'
      end

      def assign_list
        raise StandardError, 'NOT IMPLEMENTED'
      end

      def transform_list
        raise StandardError, 'NOT IMPLEMENTED'
      end

      protected

      def all_classes_by_id
        @classes_by_id
      end

      def all_classes_by_name
        @classes_by_name
      end

      def all_pairs
        @pairs
      end

      private

      def to_map(clazz)
        map = Parsed::ParsedMap.new(self)

        # name
        map_item = new_map_item('name', clazz.name)
        map.mapItems << map_item

        # superclass
        map_item = new_map_item('superclass', clazz.superclass)
        map.mapItems << map_item

        # assign
        if clazz.assign
          map_item = new_map_item('assign', clazz.assign)
          map.mapItems << map_item
        end

        # content
        if clazz.content.length.positive?
          clazz.content.each do |item|
            map_item = new_map_item(item[0], item[1])
            map.mapItems << map_item
          end
        end

        map
      end

      def new_map_item(key, value)
        map_item = Parsed::ParsedMapItem.new(self)
        map_item.pair = Parsed::ParsedPair.new(self)
        map_item.pair.key = key
        map_item.pair.valueItem = Parsed::ParsedValueItem.new(self)
        if value.is_a? Parsed::ParsedValue
          map_item.pair.valueItem.value = value
        else
          map_item.pair.valueItem.value = Parsed::ParsedValue.new(self)
          map_item.pair.valueItem.value.primitive = Parsed::ParsedPrimitive.new(self)
          map_item.pair.valueItem.value.primitive = Parsed::ParsedPrimitive.new(self)
          map_item.pair.valueItem.value.primitive.string = Parsed::ParsedString.new(value)
          map_item.pair.valueItem.value.primitive.text = value
          map_item.pair.valueItem.value.text = value
        end
        map_item
      end
    end
  end
end
