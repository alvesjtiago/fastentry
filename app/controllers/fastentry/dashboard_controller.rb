module Fastentry
  class DashboardController < ApplicationController
    def index
      @keys = Rails.cache.instance_variable_get(:@data).keys

      @cached = []
      @keys.each do |key|
        expiration_date = Rails.cache.send(:read_entry, key, {}).expires_at
        @cached << {
          cache_key: key,
          cache_value: Rails.cache.read(key.to_s),
          expiration: (Time.at(expiration_date) if expiration_date.present?)
        }
      end

      if params[:query].present?
        @cached = @cached.select { |c| c[:cache_key].include?(params[:query]) }
      end
    end
  end
end
