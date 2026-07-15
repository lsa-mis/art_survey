source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "4.0.6"

gem "bootsnap", "~> 1.24", require: false
gem "csv"
gem "devise"
gem "google-cloud-storage", require: false
gem "image_processing", "~> 1.2"
gem "importmap-rails"
gem "jbuilder"
gem "omniauth-saml", "~> 2.2"
gem "omniauth-rails_csrf_protection"
gem "pg", "~> 1.5", ">= 1.5.3"
gem "propshaft"
gem "puma", ">= 5.0"
gem "rails", "~> 8.1.3"
gem "ransack", "~> 4.2.0"
gem "request_store"
gem "sentry-ruby"
gem "sentry-rails"
gem "skylight"
gem "solid_cable"
gem "solid_cache"
gem "solid_queue"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "tailwindcss-ruby", "3.4.13"
gem "thruster", require: false
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "capybara"
  gem "selenium-webdriver", ">= 4.11"
  gem "faker"
  gem "database_cleaner-active_record"
  gem "simplecov", require: false
  gem "rails-controller-testing"
end

group :development do
  gem "web-console"
  gem "annotaterb"
end
