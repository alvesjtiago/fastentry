module Fastentry
  class StatsController < Fastentry::ApplicationController
    def index
      @number_of_keys = Fastentry.cache.keys.size
    end
  end
end
