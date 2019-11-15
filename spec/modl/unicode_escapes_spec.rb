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

require 'modl/parser/substitutions'
require 'modl/parser/unicode_escapes'

RSpec.describe MODL::Parser::UnicodeEscapes do
  it "can replace a single escape sequence when backslash syntax is used" do
    result = MODL::Parser::UnicodeEscapes.process "\\u2019"
    expect(result).to eq "\u2019"
  end
  it "can replace multiple escape sequences when backslash syntax is used" do
    result = MODL::Parser::UnicodeEscapes.process "\\u2019\\u2019"
    expect(result).to eq "\u2019\u2019"
  end
  it "can replace a single escape sequence when tilde syntax is used" do
    result = MODL::Parser::UnicodeEscapes.process "~u2019"
    expect(result).to eq "\u2019"
  end
  it "can replace multiple escape sequences when tilde syntax is used" do
    result = MODL::Parser::UnicodeEscapes.process "~u2019~u2019"
    expect(result).to eq "\u2019\u2019"
  end
  it "can replace multiple escape sequences when mixed backslash and tilde syntax is used" do
    result = MODL::Parser::UnicodeEscapes.process "~u2019\\u2019"
    expect(result).to eq "\u2019\u2019"
  end
  it "can handle up to 6 characters for the unicode escape" do
    result = MODL::Parser::UnicodeEscapes.process "~u1f476~u1f476"
    expect(result).to eq "👶👶"
    result = MODL::Parser::UnicodeEscapes.process "~u1f476"
    expect(result).to eq "👶"
    result = MODL::Parser::UnicodeEscapes.process "~u1f476x"
    expect(result).to eq "👶x"
    result = MODL::Parser::UnicodeEscapes.process "~u1f4760x"
    expect(result).to eq "👶0x"
    result = MODL::Parser::UnicodeEscapes.process "~u0020ac"
    expect(result).to eq "€"
    result = MODL::Parser::UnicodeEscapes.process "~u0020xy"
    expect(result).to eq " xy"
  end
end

RSpec.describe MODL::Parser::Substitutions do
  it "can prevent replacement of multiple escape sequences when mixed backslash and tilde syntax is used, by escaping the escapes" do
    text = "\\~u2019\\\\u2019, ~u2019\\u2019"
    text = MODL::Parser::UnicodeEscapes.process text
    result = MODL::Parser::Substitutions.process text
    expect(result).to eq "~u2019\\u2019, \u2019\u2019"
  end
end
