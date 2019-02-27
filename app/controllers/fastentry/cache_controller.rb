module Fastentry
  class CacheController < Fastentry::ApplicationController
    def show
      @key = params[:key]

      expiration = Fastentry.cache.expiration_for(@key)
      @expiration = expiration.strftime("%a, %e %b %Y %H:%M:%S %z") if expiration

      @cache_item = Fastentry.cache.read(@key)
    end

    def invalidate
      key = params[:key]
      Fastentry.cache.delete(key)

      redirect_back(fallback_location: root_path)
    end

    def invalidate_multiple
      keys = params[:invalidate_cache_keys] || []
      keys.each do |key|
        Fastentry.cache.delete(key)
      end

      redirect_back(fallback_location: root_path)
    end
  end
end
