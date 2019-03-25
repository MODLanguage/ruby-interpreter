module Modl::Parser
  class GlobalParseContext

    attr_accessor :index
    attr_accessor :pairs
    attr_accessor :classes

    def initialize
      @index = []
      @pairs = {}
      @classes = {}
    end

    def process_classes obj
    end
  end
end