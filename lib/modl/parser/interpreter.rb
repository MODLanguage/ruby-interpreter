# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright (c) 2019 NUM Technology Ltd
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

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

  class ParserError < StandardError
  end

  # This is the main Ruby Interpreter entry point. Supply a String containing MODL text and it will return a String
  # containing the JSON equivalent. The JSON isn't pretty-printed unless pretty is true
  class Interpreter
    def self.interpret(str, pretty = false)
      interpreted = MODL.parse(str)
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
