module Fastentry
  class CacheController < ApplicationController
    def show
      key = params[:key]
      @cache_item = Rails.cache.read(key)
    end

    def invalidate
      key = params[:key]
      Rails.cache.delete(key)

      redirect_back(fallback_location: root_path)
    end
  end
end
