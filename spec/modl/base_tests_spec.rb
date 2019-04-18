class Bailout < StandardError
end

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

RSpec.describe Modl::Parser do
  it "can run the success tests" do
    file = File.open("./grammar_tests/base_tests.json", "r:UTF-8")
    data = JSON.parse(file.read)

    success = 0
    failed = 0

    exit_on_fail = true

    data.each_index do |i|
      begin
        #next if i <= 205
        test_case = data[i]

        puts 'Test Input: ' + test_case['input']

        result = Modl::Parser::Interpreter.interpret test_case['input']

        expected = test_case['expected_output']

        mangle(result)
        mangle(expected)
        puts 'Expected  : ' + expected
        puts 'Found     : ' + result
        if result == expected
          puts 'Test ' + i.to_s + ' passed.'
          success += 1
        else
          puts 'Test ' + i.to_s + ' failed.'
          failed += 1
          break if exit_on_fail
        end
      rescue StandardError => e
        puts e.to_s
        puts e.backtrace
        puts 'Expected  : ' + expected.to_s
        puts 'Found     : ' + result.to_s
        puts 'Test ' + i.to_s + ' failed.'
        failed += 1
        break if exit_on_fail
      end
    end

    puts success.to_s + ' tests PASSED and ' + failed.to_s + ' tests FAILED out of a total of ' + data.length.to_s + ' tests.'
    raise Bailout if failed > 0
  end
end
