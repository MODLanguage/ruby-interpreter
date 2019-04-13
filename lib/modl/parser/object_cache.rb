require 'singleton'

module Modl
  module Parser
    # Store any files for up to 1 hour by default.
    class ObjectCache
      include Singleton
      # A cache record to keep track of the time since an object was last cached.
      class CacheEntry
        TTL_ONE_HOUR = 3_600 # seconds

        attr_reader :object

        def initialize(object, ttl = nil)
          ttl = TTL_ONE_HOUR if ttl.nil?
          @object = object
          @expiry_time = Time.now + ttl
        end

        def expired?
          @expiry_time < Time.now
        end
      end

      def initialize
        @cache = {}
      end

      def put(key, object, ttl = nil)
        @cache[key] = CacheEntry.new(object, ttl) unless key.nil? || object.nil?
      end

      def evict(key)
        @cache.delete(key) unless key.nil?
      end

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
