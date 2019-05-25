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

class Bailout < StandardError
end

require 'json'

RSpec.describe MODL::Parser do
  it "can run the failure tests" do
    file = File.open("./grammar_tests/error_tests.json", "r:UTF-8")
    data = JSON.parse(file.read)

    success = 0
    failed = 0

    exit_on_fail = false

    data.each_index do |i|
      #next if i < 45

      begin
        test_case = data[i]
        result = MODL::Interpreter.interpret test_case
        failed += 1
        puts 'Test                                 : ' + i.to_s
        puts 'Test was expected to fail but did not: ' + test_case
        puts 'Result                               : ' + result
        break if exit_on_fail
      rescue MODL::InterpreterError => e
        success += 1
        puts e.to_s
      rescue MODL::ParserError => e
        success += 1
        puts e.to_s
      end
    end

    puts success.to_s + ' tests PASSED and ' + failed.to_s + ' tests FAILED out of a total of ' + data.length.to_s + ' tests.'
    raise Bailout if failed > 0
  end
end
