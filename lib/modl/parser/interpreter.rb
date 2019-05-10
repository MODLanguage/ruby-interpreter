require 'modl/parser/MODLParserListener'
require 'modl/parser/MODLParserVisitor'
require 'modl/parser/MODLLexer'
require 'modl/parser/MODLParser'
require 'modl/parser/class_processor'
require 'modl/parser/parser'
require 'json'

module MODL
  # Interpreter-specific errors
  class InterpreterError < StandardError
  end

  # This is the main Ruby Interpreter entry point. Supply a String containing MODL text and it will return a String
  # containing the JSON equivalent. The JSON isn't pretty-printed unless pretty is true
  class Interpreter
    def self.interpret(str, pretty = false)
      # Parse the MODL string into a MODL::Parser::Parsed object.
      parsed = MODL::Parser::Parser.parse str

      # Convert the Parsed object into a simpler structure of and Array or Hash
      interpreted = parsed.extract_hash

      # Process any class definitions used by the MODL file.
      MODL::Parser::ClassProcessor.process(parsed.global, interpreted)
      MODL::Parser::InstructionProcessor.process(parsed.global, interpreted)
      # If the result is a simple string then just return it.
      return interpreted if interpreted.is_a? String

      # Otherwise generate a JSON string.
      if pretty
        JSON.pretty_generate interpreted
      else
        JSON.generate interpreted
      end
    end
  end

  # Parse a MODL string and return a hash, array, or String depending on how the MODL is structured.
  def self.parse(string)
    # Parse the MODL string into a MODL::Parser::Parsed object.
    parsed = MODL::Parser::Parser.parse(string)

    # Convert the Parsed object into a simpler structure of and Array or Hash
    interpreted = parsed.extract_hash

    # Process any class definitions used by the MODL file.
    MODL::Parser::ClassProcessor.process(parsed.global, interpreted)
    MODL::Parser::InstructionProcessor.process(parsed.global, interpreted)
    # If the result is a simple string then just return it.
    interpreted
  end
end
