module Fastentry
  class DashboardController < ApplicationController
    before_action :set_page, only: [:index]

    def index
      @keys = Rails.cache.instance_variable_get(:@data).keys

      if params[:query].present?
        @keys = @keys.select { |key| key.downcase.include?(params[:query].downcase) }
      end

      @number_of_pages = (@keys.count / @per_page.to_f).ceil

      @keys = @keys[@offset, @per_page] || []

      @cached = []
      @keys.each do |key|
        # Prevent from crashing if expiration can't be read (temporary fix)
        begin
          expiration_date = Rails.cache.send(:read_entry, key, {}).expires_at
        rescue
          expiration_date = nil
        end

        # Replaced call of value because of https://github.com/redis-store/redis-store/issues/96
        # value = Rails.cache.read(key.to_s)
        value = Rails.cache.fetch(key.to_s, raw: true) { 0 }

        @cached << {
          cache_key: key,
          cache_value: value,
          expiration: (Time.at(expiration_date) if expiration_date.present?)
        }
      end
    end

    private

    def set_page
      @page = params[:page].to_i || 0
      @per_page = 20
      @offset = @page * @per_page
    end
  end
end
