
RSpec.describe Modl::Parser do
  it "has a version number" do
    expect(Modl::Parser::VERSION).not_to be nil
  end

  it "can create a Lexer" do
    lexer = Modl::Parser::MODLLexer.new(Antlr4::Runtime::CharStreams.from_string("a=1", 'Test String'))

    expect(lexer).not_to be nil
  end

  it "can create a Parser" do
    test_strings = []
    test_strings << "?=[a;b;c;d]:[1;2;3;4;5];\ntest=%1.0"

    test_strings.each do |str|
      lexer = Modl::Parser::MODLLexer.new(Antlr4::Runtime::CharStreams.from_string(str, 'Test String'))
      tokens = Antlr4::Runtime::CommonTokenStream.new(lexer)

      parser = Modl::Parser::MODLParser.new(tokens)
      expect(parser).not_to be nil

      listener = Modl::Parser::Parsed.new

      tracer = Antlr4::Runtime::Parser::TraceListener.new(parser, tokens)
      parser.add_parse_listener(tracer)

      parsed = parser.modl
      expect(parsed).not_to be nil

      parsed.enter_rule(listener)
      parsed.exit_rule(listener)
    end
  end
end
