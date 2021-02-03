source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "bootsnap", "~> 1.7", require: false
gem "jbuilder", "~> 2.11", ">= 2.11.2"
gem "pg", "~> 1.2", ">= 1.2.3"
gem "puma", "~> 5.2"
gem "rails", "~> 6.1.0"
gem "sass-rails", "~> 6.0"
gem "turbolinks", "~> 5.2", ">= 5.2.1"
gem "webpacker", "~> 5.2", ">= 5.2.1"

group :development, :test do
  gem "faker", "~> 2.15", ">= 2.15.1"
  gem "pry-rails", "~> 0.3.9"
  gem "rspec-rails", "~> 4.0", ">= 4.0.2"
end

group :development do
  gem "letter_opener", "~> 1.7"
  gem "listen", "~> 3.4", ">= 3.4.1"
  gem "overcommit", "~> 0.57.0"
  gem "pgreset", "~> 0.3"
  gem "rack-mini-profiler", "~> 2.3", ">= 2.3.1"
  gem "rubocop", "~> 0.80.1"
  gem "spring", "~> 2.1", ">= 2.1.1"
  gem "web-console", "~> 4.1"
end

group :test do
  gem "database_cleaner", "~> 2.0"
  gem "factory_bot_rails", "~> 6.1"
  gem "rails-controller-testing", "~> 1.0", ">= 1.0.5"
  gem "shoulda-callback-matchers", "~> 1.1", ">= 1.1.4"
  gem "shoulda-matchers", "~> 4.5", ">= 4.5.1"
  gem "simplecov", "~> 0.21.2"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
