module Fastentry
  class CacheController < ApplicationController
    def show
      @key = params[:key]
      expiration_date = Rails.cache.send(:read_entry, @key, {}).expires_at
      @expiration = (Time.at(expiration_date).strftime("%a, %e %b %Y %H:%M:%S %z") if expiration_date.present?)
      @cache_item = Rails.cache.read(@key)
    end

    def invalidate
      key = params[:key]
      Rails.cache.delete(key)

      redirect_back(fallback_location: root_path)
    end
  end
end
