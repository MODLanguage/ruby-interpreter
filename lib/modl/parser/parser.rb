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
