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

# Reformat a JSON string for easier comparison of actual vs expected results.
def mangle(str)
  str = Sutil.replace(str, '": ', '":')
  str = Sutil.replace(str, '" : ', '":')
  str = Sutil.replace(str, "\n", '')
  str = Sutil.replace(str, '[ ', '[')
  str = Sutil.replace(str, ' ]', ']')
  str = Sutil.replace(str, ' }', '}')
  str = Sutil.replace(str, '] ', ']')
  str = Sutil.replace(str, '{ ', '{')
  Sutil.replace(str, ', ', ',')
end

def success_tests(data)
  success = 0
  failed = 0
  deleted_count = 0

  exit_on_fail = false

  data.each_index do |i|
    begin
      #next if i < 97

      test_case = data[i]
      if test_case['input'] == 'DELETED'
        deleted_count += 1
        next
      end

      id = test_case['id'].to_s
      puts 'Test ID: ' + id
      puts 'Test Input: ' + test_case['input']

      result = MODL::Interpreter.interpret test_case['input']

      expected = test_case['expected_output']

      result = mangle(result)
      expected = mangle(expected)
      puts 'Expected  : ' + expected
      puts 'Found     : ' + result
      if result == expected
        puts 'Test ' + id + ' passed.'
        success += 1
      else
        puts 'Test ' + id + ' failed.'
        failed += 1
        break if exit_on_fail
      end
    rescue StandardError => e
      puts e.to_s
      puts e.backtrace
      puts 'Expected  : ' + expected.to_s
      puts 'Found     : ' + result.to_s
      puts 'Test ' + id + ' failed.'
      failed += 1
      break if exit_on_fail
    end
  end
  [deleted_count, failed, success]
end

def failure_tests(data)
  success = 0
  failed = 0
  deleted_count = 0

  exit_on_fail = false

  data.each_index do |i|
    begin
      #next if i < 97

      test_case = data[i]
      if test_case['input'] == 'DELETED'
        deleted_count += 1
        next
      end

      id = test_case['id'].to_s
      puts 'Test ID: ' + id
      puts 'Test Input: ' + test_case['input']
      expected = test_case['expected_output']

      result = MODL::Interpreter.interpret test_case['input']
      puts 'Expected  : ' + expected
      puts 'Found     : ' + result
      failed += 1
      puts 'Test ' + id + ' failed.'
      break if exit_on_fail
    rescue StandardError => e
      if expected.to_s == e.message
        success += 1
      else
        failed += 1
        puts 'Test ' + id + ' failed.'
      end
      puts 'Expected  : ' + expected.to_s
      puts 'Found     : ' + e.message
    end
  end
  [deleted_count, failed, success]
end

RSpec.describe MODL::Parser do
  it "can run the error tests" do
    file = File.open("./grammar_tests/error_tests.json", "r:UTF-8")
    data = JSON.parse(file.read)

    deleted_count, failed, success = failure_tests(data)

    puts success.to_s + ' tests PASSED and ' + failed.to_s + ' tests FAILED out of a total of ' + data.length.to_s + ' tests.(' + deleted_count.to_s + ' were DELETED)'
    raise Bailout if failed > 0
  end

  it "can run the success tests" do
    file = File.open("./grammar_tests/base_tests.json", "r:UTF-8")
    data = JSON.parse(file.read)

    deleted_count, failed, success = success_tests(data)

    puts success.to_s + ' tests PASSED and ' + failed.to_s + ' tests FAILED out of a total of ' + data.length.to_s + ' tests.(' + deleted_count.to_s + ' were DELETED)'
    raise Bailout if failed > 0
  end
end
