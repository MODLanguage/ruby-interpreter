module Modl::Parser
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

    def process_classes obj
    end
  end
end