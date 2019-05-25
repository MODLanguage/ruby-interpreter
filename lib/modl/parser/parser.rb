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

require 'modl/parser/throwing_error_listener'
require 'modl/parser/parsed'

module MODL
  module Parser

    # This class converts the input string into a Modl:Parser::Parsed object for further processing.
    class Parser
      def self.parse(str, global = nil)
        begin
          lexer = MODL::Parser::MODLLexer.new(Antlr4::Runtime::CharStreams.from_string(str, 'String'))
          lexer.remove_error_listeners
          lexer.add_error_listener ThrowingErrorListener.instance

          tokens = Antlr4::Runtime::CommonTokenStream.new(lexer)

          parser = MODL::Parser::MODLParser.new(tokens)
          parser.remove_error_listeners
          parser.add_error_listener ThrowingErrorListener.instance

          global = GlobalParseContext.new if global.nil?

          parsed = Parsed.new(global)
          parser.modl.enter_rule(parsed)
          parsed
        rescue Antlr4::Runtime::ParseCancellationException => e
          check_modl_version(global)
          raise ParserError, 'Parser Error: ' + e.message
        rescue StandardError => e
          check_modl_version(global)
          raise InterpreterError, 'Interpreter Error: ' + e.message
        rescue InterpreterError => e
          check_modl_version(global)
          raise InterpreterError, 'Interpreter Error: ' + e.message
        end
      end

      def self.check_modl_version(global)
        if global.syntax_version > global.interpreter_syntax_version
          raise InterpreterError, 'Interpreter Error: MODL Version ' +
              global.interpreter_syntax_version.to_s +
              ' interpreter cannot process this MODL Version ' +
              global.syntax_version.to_s + ' file.'
        end
      end
    end
  end
end
