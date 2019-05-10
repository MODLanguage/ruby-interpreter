require 'modl/parser/object_cache'

RSpec.describe MODL::Parser do
  cache = MODL::Parser::ObjectCache.new

  it "can add a cache entry and retrieve it" do
    key1 = 'test1'
    value1 = "object1"
    cache.put(key1, value1)
    test1 = cache.get(key1)
    expect(test1).to equal(value1)
  end

  it "can add a cache entry and evict it" do
    key1 = 'test1'
    value1 = "object1"
    cache.put(key1, value1)
    cache.evict(key1)
    test1 = cache.get(key1)
    expect(test1).to equal(nil)
  end

  it "can add a cache entry and expire it" do
    key1 = 'test1'
    value1 = "object1"
    cache.put(key1, value1, 1) # expire after 1 second
    sleep 2

    test1 = cache.get(key1)
    expect(test1).to equal(nil)
  end
end
