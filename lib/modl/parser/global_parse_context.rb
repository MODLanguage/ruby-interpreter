module Modl::Parser
  class GlobalParseContext

    attr_accessor :index
    attr_accessor :pairs

    def initialize
      @index = []
      @pairs = {}
    end

  end
end