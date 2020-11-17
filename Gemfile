# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '~> 4.3.1'
gem 'bootstrap_form', github: 'bootstrap-ruby/rails-bootstrap-forms', branch: 'master'
gem 'cancancan', '~> 2.0.0'
gem 'devise', '~> 4.7.1'
gem 'groupdate', '~> 3.2.0'
gem 'haml', '~> 5.0.4'
gem 'jbuilder', '~> 2.5'
gem 'jwt', '~> 2.1.0'
gem 'mini_racer', platforms: :ruby
gem 'nokogiri', '~> 1.10.4'
gem 'pg', '~> 1.1.4'
gem 'puma', '~> 3.12.2'
gem 'rails', '~> 5.2.4'
gem 'react_on_rails', '=11.3.0' # this has to match package.json
gem 'sass-rails', '~> 5.0'
# gem 'sassc-rails', '~> 2.1.2'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 4.2.0'
gem 'will_paginate-bootstrap4'

group :development, :test do
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller'
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rails', '~> 1.2'
  gem 'faker'
  gem 'pry-rails'
  gem 'rubocop', '~> 0.52', require: false
end

group :development do
  gem 'listen', '~> 3.0.5'
end
