Embedly.configure do |config|
  # Set Embedly API key
  config.key = ENV['EMBEDLY_API_KEY']

  # Prints debug messages to the logger
  # config.debug = true

  # Use a custom logger
  # config.logger = MyAwesomeLogger.new(STDERR)

  # Choose a request adatper (net_http, typhoeus or faraday)
  # config.request_with :faraday
end
