module Modl
  module Parser
    class Error < StandardError;
    end
    # Your code goes here...
  end
end

require '../../lib/modl/parser/interpreter'
require '../../lib/modl/util/json_utilities'
require 'json'

file = File.open "../../../grammar/tests/base_tests.json"
data = JSON.parse(file.read)

success = 0
failed = 0

class_test_case = {}
class_test_case['input'] = %Q{?=one:two
test=Blah `%0.r(o,huzzah)` `%1.t(w)`}
class_test_case['expected_output'] = %Q{}
data.unshift class_test_case

exit_on_fail = true

data.each_index do |i|
  begin
    test_case = data[i]

    puts 'Test Input: ' + test_case['input']

    result = Modl::Parser::Interpreter.interpret test_case['input']

    expected = test_case['expected_output']

    if JsonUtilities.compare_json result, expected
      puts 'Test ' + i.to_s + ' passed.'
      puts 'Expected: ' + expected
      puts 'Found   : ' + result
      success += 1
    else
      puts 'Test ' + i.to_s + ' failed.'
      puts 'Expected: ' + expected
      puts 'Found   : ' + result
      failed += 1
      break if exit_on_fail
    end
  rescue StandardError => e
    puts e.to_s
    puts e.backtrace
    failed += 1
    break if exit_on_fail
  end
end

puts success.to_s + ' tests PASSED and ' + failed.to_s + ' tests FAILED out of a total of ' + data.length.to_s + ' tests.'