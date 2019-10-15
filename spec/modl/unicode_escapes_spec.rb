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

RSpec.describe MODL::Parser::Substitutions do
  it "can replace a single escape sequence when backslash syntax is used" do
    result = MODL::Parser::Substitutions.convert_unicode "\\u2019"
    expect(result).to eq "\u2019"
  end
  it "can replace multiple escape sequences when backslash syntax is used" do
    result = MODL::Parser::Substitutions.convert_unicode "\\u2019\\u2019"
    expect(result).to eq "\u2019\u2019"
  end
  it "can replace a single escape sequence when tilde syntax is used" do
    result = MODL::Parser::Substitutions.convert_unicode "~u2019"
    expect(result).to eq "\u2019"
  end
  it "can replace multiple escape sequences when tilde syntax is used" do
    result = MODL::Parser::Substitutions.convert_unicode "~u2019~u2019"
    expect(result).to eq "\u2019\u2019"
  end
  it "can replace multiple escape sequences when mixed backslash and tilde syntax is used" do
    result = MODL::Parser::Substitutions.convert_unicode "~u2019\\u2019"
    expect(result).to eq "\u2019\u2019"
  end
  it "can prevent replacement of multiple escape sequences when mixed backslash and tilde syntax is used, by escaping the escapes" do
    result = MODL::Parser::Substitutions.process "\\~u2019\\\\u2019, ~u2019\\u2019"
    expect(result).to eq "~u2019\\u2019, \u2019\u2019"
  end
end
