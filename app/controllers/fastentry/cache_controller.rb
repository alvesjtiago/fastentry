module Fastentry
  class CacheController < ApplicationController
    def invalidate
      key = params[:key]
      Rails.cache.delete(key)

      redirect_back(fallback_location: root_path)
    end
  end
end
