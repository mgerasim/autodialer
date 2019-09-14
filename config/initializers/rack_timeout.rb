Rails.application.config.middleware.insert_before Rack::Runtime, Rack::Timeout, service_timeout: 120
Rack::Timeout.timeout = 200
