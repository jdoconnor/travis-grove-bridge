# load environment
require 'dotenv'
RACK_ENV = ENV['RACK_ENV'] || 'development'
if RACK_ENV == 'test'
  Dotenv.load(".env.test")
else
  Dotenv.load
end

# load bundler
Bundler.require :default, RACK_ENV

# autoload lib
Dir['./lib/**/**/*.rb'].map {|file| require file }

# autoload initalizers
Dir['./config/initializers/**/*.rb'].map {|file| require file }

# load middleware configs
Dir['./config/middleware/**/*.rb'].map {|file| require file }

# autoload app
Dir['./app/**/**/*.rb'].map {|file| require file }
