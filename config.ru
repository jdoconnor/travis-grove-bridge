require './app'

# use Rack::Cors do
#   allow do
#     origins '*'
#     resource '*', headers: :any, methods: :any
#   end
# end
# 
# use Honeybadger::Rack
use BellyPlatform::Middleware::Logger

run TravisGroveBridge::API
  
