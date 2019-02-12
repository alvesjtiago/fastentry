module Fastentry
  class StatsController < ApplicationController
    def index
      @number_of_keys = Rails.cache.instance_variable_get(:@data).keys.count
    end
  end
end
