module Fastentry
  class DashboardController < Fastentry::ApplicationController
    before_action :set_page, only: [:index]

    def index
      total_keys = 0

      keys = Fastentry.cache.keys
      if params[:query].present?
        @keys = Fastentry.cache.search(query: params[:query], keys: keys)
        total_keys = @keys.size
        @keys = @keys.try(:[], @page * @per_page, @per_page) || []
      else
        @keys = Fastentry.cache.select(from: @page * @per_page, amount: @per_page, keys: keys)
        total_keys = keys.size
      end

      @number_of_pages = (total_keys / @per_page.to_f).ceil

      @cached =
        @keys.map do |key|
          {
            cache_key: key,
            cache_value: Fastentry.cache.read(key),
            expiration: Fastentry.cache.expiration_for(key)
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
