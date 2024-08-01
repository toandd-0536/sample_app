source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "3.2.2"
gem "active_storage_validations", "0.9.8"
gem "bcrypt", "~> 3.1.7"
gem "bootstrap-sass", "3.4.1"
gem "config"
gem "dotenv-rails", groups: [:development, :test]
gem "rails", "~> 7.0.5"
gem "sprockets-rails"
gem "mysql2", "~> 0.5"
gem "pagy"
gem "puma", "~> 5.0"
gem "i18n", "~> 1.8"
gem "i18n-js"
gem "image_processing", "1.12.2"
gem "importmap-rails"
gem "faker"
gem "pry-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "sassc-rails"
gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i(mri mingw x64_mingw)
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
