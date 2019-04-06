require 'modl/parser/file_cache'

RSpec.describe Modl::Parser do
  it "can add a cache entry and retrieve it" do
    key1 = 'test1'
    value1 = "object1"
    Modl::Parser::FileCache.instance.put(key1, value1)
    test1 = Modl::Parser::FileCache.instance.get(key1)
    expect(test1).to equal(value1)
  end

  it "can add a cache entry and evict it" do
    key1 = 'test1'
    value1 = "object1"
    Modl::Parser::FileCache.instance.put(key1, value1)
    Modl::Parser::FileCache.instance.evict(key1)
    test1 = Modl::Parser::FileCache.instance.get(key1)
    expect(test1).to equal(nil)
  end

  it "can add a cache entry and expire it" do
    key1 = 'test1'
    value1 = "object1"
    Modl::Parser::FileCache.instance.put(key1, value1, 1) # expire after 1 second
    sleep 2

    test1 = Modl::Parser::FileCache.instance.get(key1)
    expect(test1).to equal(nil)
  end
end
