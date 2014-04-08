# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.expect_with :rspec          # => rspec/expectations
  config.expect_with :stdlib         # => Test::Unit or MinitTest
  config.expect_with :rspec, :stdlib # => both
  config.before(:suite) {DatabaseCleaner.strategy = :truncation}
  config.before(:each) {DatabaseCleaner.start}
  config.after(:each) {DatabaseCleaner.clean}
  config.include FactoryGirl::Syntax::Methods
end
