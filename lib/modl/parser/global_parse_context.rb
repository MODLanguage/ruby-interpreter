module Modl
  module Parser
    # Each time we run the parser on a MODL file we need to keep track of a few things so they can be made available
    # to other areas of the code. This class is the container for that contextual information, which is gathered
    # as the Modl::Parser:Parsed object processes the parse tree.
    class GlobalParseContext
      attr_accessor :index
      attr_accessor :pairs
      attr_accessor :classes
      attr_accessor :methods_hash
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
