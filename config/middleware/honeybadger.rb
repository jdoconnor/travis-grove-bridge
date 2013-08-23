Honeybadger.configure do |config|
  config.environment_name = RACK_ENV
  config.api_key = ENV['HONEYBADGER_API_KEY']
end
