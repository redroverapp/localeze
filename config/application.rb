require File.expand_path('../boot', __FILE__)
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'active_resource/railtie'
Bundler.require(:default, Rails.env) if defined?(Bundler)
module Localeze
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
  end
end