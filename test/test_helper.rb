ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'pry'

class ActiveSupport::TestCase
  Faker::Config.locale = 'en-US'
  FactoryGirl.lint

  Delayed::Worker.delay_jobs = false


  # TODO: Remove this
  Source.skip_callback(:create, :after, :process_job)
end
