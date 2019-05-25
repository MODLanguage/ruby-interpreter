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

require 'modl/parser/ref_processor'

RSpec.describe MODL::Parser do
  it "can detect ref paths correctly" do
    tests = []
    tests << {'ref' => 'xxx`80aafnhi4ae`.trim(abc,def);yyy', 'result' => '`80aafnhi4ae`.trim(abc,def)'}
    tests << {'ref' => 'xxx`80aafnhi4ae`.trim(abc,def).p.u;yyy', 'result' => '`80aafnhi4ae`.trim(abc,def).p.u'}
    tests << {'ref' => '%test', 'result' => '%test'}
    tests << {'ref' => '%_test', 'result' => '%_test'}
    tests << {'ref' => '%_test_2', 'result' => '%_test_2'}
    tests << {'ref' => 'xxx`%test`yyy', 'result' => '`%test`'}
    tests << {'ref' => 'xxx%test.0.a.%x.%y.z.u.replace(a,b).r(c,d).u.e;yyy', 'result' => '%test.0.a.%x.%y.z.u.replace(a,b).r(c,d).u.e'}
    tests << {'ref' => '%0', 'result' => '%0'}
    tests << {'ref' => 'xxx%0yyy', 'result' => '%0'}
    tests << {'ref' => '`%string.replace(this,that).upcase`', 'result' => '`%string.replace(this,that).upcase`'}

    tests.each do |test|
      result = MODL::Parser::RefProcessor::MATCHER.match(test['ref'])
      expect(result).not_to be nil
      expect(result[0]).to eq(test['result'])
    end
  end
end
