require 'fastentry/engine'
require 'awesome_print'

module Fastentry
  class Cache < SimpleDelegator
    alias cache __getobj__

    def expiration_for(key)
      expires_at = cache.send(:read_entry, key, {}).expires_at
      expires_at.strip.empty? ? nil : Time.at(expires_at)
    rescue StandardError
      nil
    end

    def read(key)
      cache.read(key)
    rescue StandardError
      nil
    end

    def self.for(cache)
      case cache
      when ActiveSupport::Cache::Strategy::LocalCache
        LocalCache.new(cache)
      when ActiveSupport::Cache::RedisCacheStore
        RedisCache.new(cache)
      else
        raise ArgumentError, 'Unsupported cache type'
      end
    end
  end

  class LocalCache < Cache
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
