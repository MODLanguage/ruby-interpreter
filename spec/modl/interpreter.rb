class Bailout < StandardError
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

def tests_that_should_pass
  file = File.open "./grammar_tests/base_tests.json"
  data = JSON.parse(file.read)

  success = 0
  failed = 0

  exit_on_fail = false

  data.each_index do |i|
    begin

      test_case = data[i]

      result = Modl::Parser::Interpreter.interpret test_case['input']

      expected = test_case['expected_output']

      mangle(result)
      mangle(expected)
      if result == expected
        success += 1
      else
        puts 'Test ' + i.to_s + ' failed.'
        puts 'Test Input: ' + test_case['input']
        puts 'Expected  : ' + expected
        puts 'Found     : ' + result
        failed += 1
        break if exit_on_fail
      end
    rescue StandardError => e
      puts e.to_s
      puts e.backtrace
      if result == expected
        success += 1
      else
        puts 'Test ' + i.to_s + ' failed.'
        puts 'Test Input: ' + test_case['input'].to_s
        puts 'Expected  : ' + expected.to_s
        puts 'Found     : ' + result.to_s
        failed += 1
        break if exit_on_fail
      end
    end
  end

  puts success.to_s + ' tests PASSED and ' + failed.to_s + ' tests FAILED out of a total of ' + data.length.to_s + ' tests.'
  if failed > 0
    raise Bailout
  end
end

def tests_that_should_fail
  file = File.open "./grammar_tests/error_tests.json"
  data = JSON.parse(file.read)

  success = 0
  failed = 0

  exit_on_fail = false

  data.each_index do |i|
    begin
      test_case = data[i]
      result = Modl::Parser::Interpreter.interpret test_case
      failed += 1
      puts 'Test was expected to fail but did not: ' + test_case
      puts 'Result                               : ' + result
      break if exit_on_fail
    rescue StandardError => e
      success += 1
      puts e.to_s
      puts e.backtrace
    end
  end

  puts success.to_s + ' tests PASSED and ' + failed.to_s + ' tests FAILED out of a total of ' + data.length.to_s + ' tests.'
  if failed > 0
    raise Bailout
  end
end

puts 'Running tests that should pass.'
tests_that_should_pass

puts 'Running tests that should fail.'
tests_that_should_fail

puts 'Testing complete.'
