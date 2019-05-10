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
