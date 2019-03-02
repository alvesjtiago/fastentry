require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment.rb', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
