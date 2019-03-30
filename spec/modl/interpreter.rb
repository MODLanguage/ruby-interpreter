module Modl
  module Parser
    class Error < StandardError;
    end
    # Your code goes here...
  end
end

require '../../lib/modl/parser/interpreter'
require 'json'

def mangle(str)
  loop do
    break unless str.sub!('": ', '":')
  end

  loop do
    break unless str.sub!('" : ', '":')
  end

  loop do
    break unless str.sub!("\n", '')
  end

  loop do
    break unless str.sub!('[ ', '[')
  end

  loop do
    break unless str.sub!(' ]', ']')
  end

  loop do
    break unless str.sub!(' }', '}')
  end

  loop do
    break unless str.sub!('] ', ']')
  end

  loop do
    break unless str.sub!('{ ', '{')
  end

  loop do
    break unless str.sub!(', ', ',')
  end
end

file = File.open "../../../grammar/tests/base_tests.json"
data = JSON.parse(file.read)

success = 0
failed = 0

data.unshift data[58]

exit_on_fail = false

data.each_index do |i|
  begin
    test_case = data[i]

    puts 'Test Input: ' + test_case['input']

    result = Modl::Parser::Interpreter.interpret test_case['input']

    expected = test_case['expected_output']

    mangle(result)
    mangle(expected)
    if result == expected
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