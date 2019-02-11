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
  spec.summary     = "Summary of FastEntry"
  spec.description = "Description"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "> 5.0"
  spec.add_dependency 'awesome_print'
end
