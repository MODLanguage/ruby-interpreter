module MODL
  module Parser
    # Each time we run the parser on a MODL file we need to keep track of a few things so they can be made available
    # to other areas of the code. This class is the container for that contextual information, which is gathered
    # as the MODL::Parser:Parsed object processes the parse tree.
    class GlobalParseContext

      attr_accessor :syntax_version
      attr_accessor :max_files_allowed
      attr_reader :interpreter_syntax_version
      attr_reader :loaded_files

      def initialize
        # This is set to true if we encounter a *L[OAD] instruction
        @max_files_allowed = 2147483647
        # Holds the index array from a MODL file, e.g. '?=a:b:c:d'
        @index = []
        # Contains all pairs as they are encountered in the parsing process.
        @pairs = {}
        # Contains all defined and loaded classes for the current MODL document.
        @classes_by_id = {}
        @classes_by_name = {}
        # Hold the user-defined methods.
        @methods_hash = {}
        @methods_by_id = {}
        # Tracks the nesting depth for conditional clauses.
        @conditional = 0
        # Defaults to 1 and can be overridden by the *version command.
        @syntax_version = 1
        @interpreter_syntax_version = 1
        @loaded_files = []
      end

      def loaded_file(str)
        @loaded_files << str unless str.nil?
        raise InterpreterError, 'Cannot load multiple files after *LOAD instruction' if @loaded_files.length > @max_files_allowed

      end

      def index_value(n, default)
        return default if n > @index.length

        @index[n]
      end

      def in_condition?
        @conditional.positive?
      end

      def freeze_max_files(plus)
        @max_files_allowed = @loaded_files.length + plus
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
          result = @classes_by_name[key] if result.nil?
          result
        elsif key.is_a? MODLClass
          @classes_by_id[key.id] = key if key.id
          @classes_by_name[key.name] = key if key.name
        end
      end

      def merge_pairs(other)
        @pairs.merge!(other.all_pairs)
      end

      def merge_classes(other)
        @classes_by_id.merge!(other.all_classes_by_id)
        @classes_by_name.merge!(other.all_classes_by_name)
      end

      def merge_loaded_files(other)
        @loaded_files.concat(other.loaded_files)
        raise InterpreterError, 'Cannot load multiple files after *LOAD instruction' if @loaded_files.length > @max_files_allowed
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

      def user_method_id(key, val)
        @methods_hash[key] = val
        @methods_by_id[key] = val
      end

      def class_list
        result = []
        @classes_by_id.values.each do |clazz|
          new_item = {}
          new_item[clazz.id] = class_to_hash(clazz)
          result << new_item
        end
        result
      end

      def method_list
        result = []
        @methods_by_id.values.each do |m|
          new_item = {}
          new_item[m.id] = method_to_hash(m)
          result << new_item
        end
        result
      end

      def file_list
        @loaded_files.dup
      end

      def id_list
        ids = {}
        ids['methods'] = @methods_by_id.keys.dup.sort!
        ids['classes'] = @classes_by_id.keys.dup.sort!
        ids
      end

      def name_list
        names = {}
        names['methods'] = @methods_hash.keys.dup.sort!
        names['classes'] = @classes_by_name.keys.dup.sort!
        names
      end

      def superclass_list
        result = {}
        @classes_by_id.each do |c|
          result[c[0]] = c[1].superclass
        end
        result
      end

      def assign_list
        result = {}
        @classes_by_id.each do |c|
          result[c[0]] = c[1].assign
        end
        result
      end

      def transform_list
        result = {}
        @methods_by_id.each do |c|
          result[c[0]] = c[1].transform
        end
        result
      end

      def allow_list
        result = {}
        @classes_by_id.each do |c|
          result[c[0]] = c[1].allow.nil? ? nil : c[1].allow.extract_hash
        end
        result
      end

      protected

      def all_classes_by_id
        @classes_by_id
      end

      def all_classes_by_name
        @classes_by_name
      end

      def all_pairs
        result = {}
        @pairs.keys.each do |k|
          result[k] = @pairs[k] unless k.start_with?('*')
        end
        result
      end

      private

      def class_to_hash(clazz)
        map = {}
        # name
        map['name'] = clazz.name

        # superclass
        map['superclass'] = clazz.superclass

        # assign
        if clazz.assign
          map['assign'] = clazz.assign
        end

        # allow
        if clazz.allow
          map['allow'] = clazz.allow.extract_hash
        end

        # expect
        if clazz.expect
          map['expect'] = clazz.expect.extract_hash
        end

        # content
        if clazz.content.length.positive?
          clazz.content.each do |item|
            map[item[0]] = item[1].extract_hash
          end
        end

        map
      end

      def method_to_hash(mthd)
        map = {}
        # name
        map['name'] = mthd.name

        # superclass
        map['transform'] = mthd.transform

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
