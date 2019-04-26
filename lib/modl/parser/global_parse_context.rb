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
        @classes = {}
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

      def classs(key, clazz = nil)
        return @classes[key] unless clazz

        @classes[key] = clazz
      end

      def merge_pairs(other)
        @pairs.merge!(other.all_pairs)
      end

      def merge_classes(other)
        @classes.merge!(other.all_classes)
      end

      def has_pairs?
        @pairs.length.positive?
      end

      def has_class?(key)
        @classes.keys.include?(key)
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

      protected

      def all_classes
        @classes
      end

      def all_pairs
        @pairs
      end
    end
  end
end
