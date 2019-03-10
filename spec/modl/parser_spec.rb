RSpec.describe Modl::Parser do
  it "has a version number" do
    expect(Modl::Parser::VERSION).not_to be nil
  end

  it "can create a Lexer" do
    lexer = MODL::Parser::MODLLexer.new(CharStreams.from_string("a=1", 'Test String'))

    expect(lexer).not_to be nil
  end
end
