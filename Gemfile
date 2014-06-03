source 'https://rubygems.org'

gem 'redis'
gem 'activemodel'
gem 'mongoid', '>=3.1.6'
gem 'sidekiq', '2.17.7'
gem 'sendgrid_webapi', '0.0.3'
gem 'librato-metrics'
gem 'rubysl', platform: :rbx
gem 'jruby-openssl', platform: :jruby
gem 'yajl-ruby', :platforms=>[:rbx,:ruby]
gem 'json-schema'

group :development do
  gem 'rake'
  gem 'pry'
  gem 'pry-nav'
  gem 'yard'
end

group :test do
  gem 'rspec', '>= 3.0.0'
  gem 'rspec-mocks'
  gem 'rspec-expectations'
  gem 'database_cleaner'
  gem 'factory_girl', '4.2.0'
  gem 'vcr'
  gem 'webmock', '>= 1.8.0', '< 1.16'
  gem 'coveralls', platform: :ruby, require: false
end
