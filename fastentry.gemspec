$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "fastentry/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "fastentry"
  spec.version     = Fastentry::VERSION
  spec.authors     = ["Tiago Alves"]
  spec.email       = ["alvesjtiago@gmail.com"]
  spec.homepage    = "https://github.com/alvesjtiago/fastentry"
  spec.summary     = "Cache management for Rails"
  spec.description = "Cache management for Rails"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "> 4.0"
  spec.add_dependency 'awesome_print'

  spec.add_development_dependency 'sqlite3', '~> 1.3.13'
end
