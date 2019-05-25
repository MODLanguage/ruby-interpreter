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
