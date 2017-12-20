ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'

require 'simplecov'
SimpleCov.start do
	add_filter "spec/*"
	add_filter "config/*"
	add_filter "db/seeds.rb"
end

include RSpec

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
	config.include Sorcery::TestHelpers::Rails
	
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.example_status_persistence_file_path = "spec/examples.txt"

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed

  config.before(:suite) do
    Rails.application.load_seed
  end
end
