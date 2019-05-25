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


RSpec.describe MODL::Parser do
  it "has a version number" do
    expect(MODL::Parser::VERSION).not_to be nil
  end

  it "can create a Lexer" do
    lexer = MODL::Parser::MODLLexer.new(Antlr4::Runtime::CharStreams.from_string("a=1", 'Test String'))

    expect(lexer).not_to be nil
  end

  it "can create a Parser" do
    test_strings = []
    test_strings << "?=[a;b;c;d]:[1;2;3;4;5];\ntest=%1.0"

    test_strings.each do |str|
      lexer = MODL::Parser::MODLLexer.new(Antlr4::Runtime::CharStreams.from_string(str, 'Test String'))
      tokens = Antlr4::Runtime::CommonTokenStream.new(lexer)

      parser = MODL::Parser::MODLParser.new(tokens)
      expect(parser).not_to be nil

      listener = MODL::Parser::Parsed.new

      tracer = Antlr4::Runtime::Parser::TraceListener.new(parser, tokens)
      parser.add_parse_listener(tracer)

      parsed = parser.modl
      expect(parsed).not_to be nil

      parsed.enter_rule(listener)
      parsed.exit_rule(listener)
    end
  end
end
