source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.4"

# Add these lines to handle deprecation warnings
gem 'bigdecimal'
gem 'mutex_m'
gem 'observer'

gem 'actionpack'
gem 'activesupport'
gem "bootsnap", require: false
gem "devise"
gem "google-cloud-storage", require: false
gem "image_processing"
gem "importmap-rails"
gem "jbuilder"
gem "ldap_lookup", "~> 0.1.6"
gem "omniauth-saml", "~> 2.1"
gem "omniauth-rails_csrf_protection"
gem 'pg', '~> 1.5', '>= 1.5.3'
gem "puma"
gem "rails", "7.2.2.1"
gem "ransack", "~> 4.2.0"
gem "redis"
gem "skylight"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "tailwindcss-ruby", "3.4.13"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "capybara"
  gem "webdrivers"
  gem "faker"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem "annotate", "~> 3.2"
end
