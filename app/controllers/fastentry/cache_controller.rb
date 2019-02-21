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
  end
end
