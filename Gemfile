source 'https://rubygems.org'

#ruby '2.0.0'
gem  'rails'

gem 'pg'
#gem 'mongo'
#gem 'bson_ext'

gem 'awesome_print'

# Gem used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem "less-rails"
  gem 'libv8', '~> 3.11.8'
end

group :development do
  gem 'hpricot'
  gem 'ruby_parser'
  gem 'quiet_assets'
  gem "rspec-rails", "~> 2.0"

  gem 'html2haml'
end

group :test, :development do
  gem "rspec-rails", "~> 2.0"
  gem 'spork', '~> 1.0rc'
end

gem 'haml'
gem 'slim'
gem 'twitter-bootstrap-rails'
gem 'rails-i18n'

gem 'mechanize'

gem 'jquery-rails'

# Use unicorn as the app server
gem 'unicorn'
gem 'foreman'

gem 'sidekiq'
gem 'sidekiq-failures'
gem 'sinatra', '>= 1.3.0', :require => nil

