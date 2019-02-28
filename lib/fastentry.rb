require 'fastentry/engine'
require 'awesome_print'

module Fastentry
  class Cache < SimpleDelegator
    alias cache __getobj__

    def expiration_for(key)
      expires_at = cache.send(:read_entry, key, {}).expires_at
      expires_at.to_s.strip.empty? ? nil : Time.at(expires_at)
    rescue StandardError
      nil
    end

    def read(key)
      cache.read(key)
    rescue StandardError
      nil
    end

    def self.for(cache)
      if ::Rails::VERSION::MAJOR >= 5
        # Comparing cache name due to class require statements:
        ## ex. https://github.com/rails/rails/blob/94b5cd3a20edadd6f6b8cf0bdf1a4d4919df86cb/activesupport/lib/active_support/cache/redis_cache_store.rb#L5
        case cache.class.name
        when "ActiveSupport::Cache::FileStore"
          DefaultCache.new(cache)
        when "ActiveSupport::Cache::MemoryStore"
          DefaultCache.new(cache)
        when "ActiveSupport::Cache::RedisCacheStore"
          RedisCache.new(cache)
        when "ActiveSupport::Cache::MemCacheStore"
          DefaultCache.new(cache)
        else
          raise ArgumentError, 'Unsupported cache type'
        end
      else
        DefaultCache.new(cache)
      end
    end
  end

  class DefaultCache < Cache
    def keys
      cache.instance_variable_get(:@data).keys
    end
  end

  class RedisCache < Cache
    def keys
      cache.redis.keys
    end
  end

  def self.cache
    @cache ||= Cache.for(Rails.cache)
  end
end
