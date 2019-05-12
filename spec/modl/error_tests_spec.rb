class Bailout < StandardError
end

require 'json'

RSpec.describe MODL::Parser do
  it "can run the failure tests" do
    file = File.open "./grammar_tests/error_tests.json"
    data = JSON.parse(file.read)

    success = 0
    failed = 0

    exit_on_fail = false

    data.each_index do |i|
      #next if i <= 45

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
