Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook, ENV['262325467304404'], ENV['5eee7efe1894566815df8ecc1689ce66']
  provider :facebook, '262325467304404', '5eee7efe1894566815df8ecc1689ce66'
end
