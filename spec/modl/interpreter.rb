require './modl_parser_test_listener'
require '../../lib/modl/parser/MODLLexer'
require '../../lib/modl/parser/MODLParser'

test_strings = []
test_strings << "?=[a;b;c;d]:[1;2;3;4;5]\ntest=%1[0]"

test_strings.each do |str|
  lexer = Modl::Parser::MODLLexer.new(Antlr4::Runtime::CharStreams.from_string(str, 'Test String'))
  tokens = Antlr4::Runtime::CommonTokenStream.new(lexer)

  parser = Modl::Parser::MODLParser.new(tokens)

  listener = MODLParserTestListener.new

  tracer = Antlr4::Runtime::Parser::TraceListener.new(parser, tokens)
  parser.add_parse_listener(tracer)

  parsed = parser.modl

  parsed.enter_rule(listener)
  parsed.exit_rule(listener)
end
