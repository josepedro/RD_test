require_relative 'boot'

require 'rails/all'
require 'pry'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RDStation
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.middleware.use Rack::Cors do
       allow do
         origins '*'
         resource 'api/jquery', :headers => :any, :methods => [:get, :post]
       end
    end
  end
end
