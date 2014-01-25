source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.2'

gem 'mysql2', '0.3.14'
gem 'sass-rails', '4.0.1'
gem 'uglifier', '2.4.0'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails', '3.0.4'
gem 'jquery-ui-rails', '4.1.1'
gem 'jbuilder', '2.0.2'

# authentication strategies ####
gem 'dummy-auth-rails',
  git: "git@innersource.accenture.com:/gems-and-plugins/dummy-auth-rails.git"
#################################

gem 'cancan', '1.6.10'

group :development, :test do
  gem 'rspec-rails', '2.14.1'
  gem 'factory_girl_rails', '4.3.0'
end

group :test do
  gem 'ci_reporter', '1.9.1'
  gem 'simplecov', '0.8.2', :require => false
  gem 'simplecov-rcov', '0.2.3', :require => false
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '0.4.0', require: false
end
