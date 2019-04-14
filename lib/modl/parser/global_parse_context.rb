module Modl
  module Parser
    # Each time we run the parser on a MODL file we need to keep track of a few things so they can be made available
    # to other areas of the code. This class is the container for that contextual information, which is gathered
    # as the Modl::Parser:Parsed object processes the parse tree.
    class GlobalParseContext
      # Holds the index array from a MODL file, e.g. '?=a:b:c:d'
      attr_accessor :index
      # Contains all pairs as they are encountered in the parsing process.
      attr_accessor :pairs
      # Contains all defined and loaded classes for the current MODL document.
      attr_accessor :classes
      # Hold the user-defined methods.
      attr_accessor :methods_hash
      # Tracks the nesting depth for conditional clauses.
      attr_accessor :conditional

      def initialize
        @index = []
        @pairs = {}
        @classes = {}
        @methods_hash = {}
        @conditional = 0
      end
    end
  end
end
