require 'modl/parser/MODLParserListener'
require 'modl/parser/MODLParserVisitor'
require 'modl/parser/MODLLexer'
require 'modl/parser/MODLParser'
require 'modl/parser/Parser'
require 'json'

module Modl::Parser
  class Interpreter
    def self.interpret(str)
      parsed = Modl::Parser::Parser.parse str
      interpreted = parsed.extract_json
      JSON.generate interpreted
    end
  end
end