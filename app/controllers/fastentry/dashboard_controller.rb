module Fastentry
  class DashboardController < Fastentry::ApplicationController
    before_action :set_page, only: [:index]

    def index
      @keys = Fastentry.cache.keys

      if params[:query].present?
        @keys.select! { |key| key.downcase.include?(params[:query].downcase) }
      end

      @number_of_pages = (@keys.count / @per_page.to_f).ceil
      @keys = @keys[@offset, @per_page] || []

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
