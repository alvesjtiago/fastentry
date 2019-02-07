module Fastentry
  class Engine < ::Rails::Engine
    isolate_namespace Fastentry

    initializer "engine_name.assets.precompile" do |app|
      app.config.assets.precompile += %w( fastentry/logo.png )
    end
  end
end
