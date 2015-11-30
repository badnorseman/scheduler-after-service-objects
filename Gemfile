source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Add jquery to the JavaScript library
gem 'jquery-rails'
# Monitor Ruby Gems are out-of-date or vulnerable
gem 'gemsurance'
# Memcached store cashe on server
gem 'dalli'
# Use PostgreSQL as database
gem 'pg'

group :doc do
  # Bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0'
end

group :development, :test do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Handle error requests for debugging
  gem 'meta_request'
  # Monitor application performance
  gem 'bullet'
  # Display json objects pretty
  gem 'awesome_print'
  # Write test scripts. Read more: http://github.com/rspec/rspec
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  # Debug source code
  gem 'pry-rails'
  gem 'quiet_assets'
end

group :production do
  # Use Thin as production web server
  gem 'thin'
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
