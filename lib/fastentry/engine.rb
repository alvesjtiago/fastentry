module Fastentry
  class Engine < ::Rails::Engine
    isolate_namespace Fastentry

    initializer "engine_name.assets.precompile" do |app|
      app.config.assets.precompile += %w( fastentry/logo.png fastentry/applications.css application.js )
    end

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
