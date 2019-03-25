require 'modl/parser/MODLParserListener'
require 'modl/parser/MODLParserVisitor'
require 'modl/parser/MODLLexer'
require 'modl/parser/MODLParser'
require 'modl/parser/Parser'
require 'modl/parser/class_processor'
require 'json'

module Modl::Parser
  class Interpreter
    def self.interpret(str)
      parsed = Modl::Parser::Parser.parse str
      interpreted = parsed.extract_json
      ClassProcessor.instance.process(parsed.global, interpreted)
      JSON.generate interpreted
    end
  end
end