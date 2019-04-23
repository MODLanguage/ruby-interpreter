
module Modl
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
