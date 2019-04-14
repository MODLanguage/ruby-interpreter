require 'modl/parser/throwing_error_listener'
require 'modl/parser/parsed'

module Modl
  module Parser

    # This class converts the input string into a Modl:Parser::Parsed object for further processing.
    class Parser
      def self.parse(str, global = nil)
        begin
          lexer = Modl::Parser::MODLLexer.new(Antlr4::Runtime::CharStreams.from_string(str, 'String'))
          lexer.remove_error_listeners
          lexer.add_error_listener ThrowingErrorListener.instance

          tokens = Antlr4::Runtime::CommonTokenStream.new(lexer)

          parser = Modl::Parser::MODLParser.new(tokens)
          parser.remove_error_listeners
          parser.add_error_listener ThrowingErrorListener.instance

          parsed = Parsed.new(global)
          parser.modl.enter_rule(parsed)
          parsed
        rescue Antlr4::Runtime::ParseCancellationException => e
          puts e.to_s
          puts e.backtrace
          raise InterpreterError, 'Parser Error: ' + e.message
        end
      end
    end
  end
end
