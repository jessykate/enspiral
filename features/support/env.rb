# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a 
# newer version of cucumber-rails. Consider adding your own code to a new file 
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require 'cucumber/rails'
require 'capybara/poltergeist'

Capybara.default_selector = :css
Capybara.default_driver = :rack_test
Capybara.javascript_driver = :poltergeist

ActionController::Base.allow_rescue = false
#Cucumber::Rails::Database.javascript_strategy = :truncation
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.orm = "active_record"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
