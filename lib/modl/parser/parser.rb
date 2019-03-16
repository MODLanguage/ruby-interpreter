require 'modl/parser/throwing_error_listener'

module Modl::Parser

  class Parser
    def self.parse(str)
      lexer = Modl::Parser::MODLLexer.new(Antlr4::Runtime::CharStreams.from_string(str, 'String'))
      lexer.remove_error_listeners
      lexer.add_error_listener ThrowingErrorListener.instance

      tokens = Antlr4::Runtime::CommonTokenStream.new(lexer)

      parser = Modl::Parser::MODLParser.new(tokens)
      parser.remove_error_listeners
      parser.add_error_listener ThrowingErrorListener.instance

      parsed = Parsed.new

      parser.modl.enter_rule(parsed)
      return parsed
    end
  end
end