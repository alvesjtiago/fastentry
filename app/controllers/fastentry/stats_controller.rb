module Fastentry
  class StatsController < Fastentry::ApplicationController
    def index
      @number_of_keys = Fastentry.cache.number_of_keys
    end
  end
end
