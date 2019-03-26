require 'modl/parser/ref_processor'

RSpec.describe Modl::Parser do
  it "can extract ref tokens" do

    new_values = {}
    new_values['1'] = 'ref1'
    new_values['name'] = 'the_name'
    test_string = 'Some text with refs:%1.u also%`name.s`s as well.'

    result = Modl::Parser::RefProcessor.instance.split_by_ref_tokens test_string, new_values
    puts result.to_s
  end
end
