require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'rails/test_unit/railtie'

Bundler.require(:default, DEVISE_ORM) if defined?(Bundler)
Bundler.require(:default, 'devise-dynamoid') if defined?(Bundler) and DEVISE_ORM == :dynamoid

begin
    require "#{DEVISE_ORM}" if (DEVISE_ORM == :mongoid or DEVISE_ORM == :dynamoid)
    # require 'devise-dynamoid' if DEVISE_ORM == :dynamoid
    require "#{DEVISE_ORM}/railtie" unless (DEVISE_ORM == :mongoid && Mongoid::VERSION >= '5.0.0') # or DEVISE_ORM == :dynamoid
rescue LoadError
end
PARENT_MODEL_CLASS = DEVISE_ORM == :active_record ? ActiveRecord::Base : Object
Mongoid.load!(File.expand_path('../../mongoid.yml', __FILE__)) if DEVISE_ORM == :mongoid && Mongoid::VERSION < '3.0.0'
# Dynamoid.load!(File.expand_path('../../dynamoid.yml', __FILE__)) if DEVISE_ORM == :dynamoid

require 'devise'
require 'devise_invitable'

module RailsApp
    class Application < Rails::Application
        config.filter_parameters << :password
        config.action_mailer.default_url_options = { host: 'localhost:3000' }
        if DEVISE_ORM == :active_record && Rails.version.start_with?('5')
            config.active_record.maintain_test_schema = false
            config.active_record.sqlite3.represent_boolean_as_integer = true if config.active_record.sqlite3
        end
    end
end
