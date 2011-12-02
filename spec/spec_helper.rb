ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.mock_with :mocha
end
def login_admin
  @admin = User.first(:conditions => {:email => 'someone@seologic.com'}) || User.make(:email => 'someone@seologic.com')
  sign_in @admin
end