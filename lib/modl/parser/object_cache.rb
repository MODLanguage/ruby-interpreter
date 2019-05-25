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

module MODL
  module Parser
    # Store any files for up to 1 hour by default.
    class ObjectCache
      # A cache record to keep track of the time since an object was last cached.
      class CacheEntry
        TTL_ONE_HOUR = 3_600 # seconds

        attr_reader :object

        # Initialiase the CacheEntry with an object and an optional ttl in seconds (default 1 hour)
        def initialize(object, ttl = nil)
          ttl = TTL_ONE_HOUR if ttl.nil?
          @object = object
          @expiry_time = Time.now + ttl
        end

        # Check whether the CacheEntry is live
        def expired?
          @expiry_time < Time.now
        end
      end

      # Set up and empty cache.
      def initialize
        @cache = {}
      end

      # Cache an object with the given key and optional ttl in seconds (default 1 hour)
      def put(key, object, ttl = nil)
        @cache[key] = CacheEntry.new(object, ttl) unless key.nil? || object.nil?
      end

      # Evict a cache entry
      def evict(key)
        @cache.delete(key) unless key.nil?
      end

      # Return the object with the given key if one exists and has not expired.
      def get(key)
        # Return nothing if not in the cache or it has expired.
        return if key.nil?

        entry = @cache[key]
        return unless entry
        return if entry.expired?

        # Otherwise return the cached object.
        entry.object
      end
    end
  end
end
