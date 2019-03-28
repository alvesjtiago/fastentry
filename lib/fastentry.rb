require 'fastentry/engine'
require 'awesome_print'
require 'memcached'

module Fastentry
  class Cache < SimpleDelegator
    alias cache __getobj__

    def number_of_keys
      keys.size
    end

    def select(from: 0, amount: 20)
      count = adjusted_amount(from, amount)
      keys.try(:[], from, count) || []
    end

    def search(query: '')
      keys.select! { |key| key.downcase.include?(query.downcase) } || []
    end

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
          MemcacheCache.new(cache)
        when "ActiveSupport::Cache::DalliStore"
          DalliCache.new(cache)
        else
          raise ArgumentError, 'Unsupported cache type'
        end
      else
        case cache.class.name
        when "ActiveSupport::Cache::MemCacheStore"
          DalliCache.new(cache)
        when "ActiveSupport::Cache::DalliStore"
          DalliCache.new(cache)
        else
          DefaultCache.new(cache)
        end
      end
    end

    private

      def adjusted_amount(from, amount)
        from + amount > number_of_keys ? (number_of_keys - from) : amount
      end
  end

  class MemcacheCache < Cache
    def keys
      Memcached.keys(Rails.cache.stats.keys.first)
    end
  end

  class DalliCache < Cache
    def keys
      Memcached.keys(Rails.cache.dalli.stats.keys.first)
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

    def number_of_keys
      cache.redis.dbsize
    end

    def select(from: 0, amount: 20)
      count = adjusted_amount(from, amount)
      cache.redis.scan(from, count: count)[1]
    end

    def search(query: '')
      cache.redis.scan_each(match: "*#{query.downcase}*").to_a.uniq
    end
  end

  def self.cache
    @cache ||= Cache.for(Rails.cache)
  end
end
