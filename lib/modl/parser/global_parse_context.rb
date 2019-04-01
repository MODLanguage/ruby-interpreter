module Modl::Parser
  class GlobalParseContext

    attr_accessor :index
    attr_accessor :pairs
    attr_accessor :classes
    attr_accessor :methods_hash

    def initialize
      @index = []
      @pairs = {}
      @classes = {}
      @methods_hash = {}
    end

    def process_classes obj
    end
  end
end