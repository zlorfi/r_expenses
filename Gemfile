# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '~> 4.3.1'
gem 'bootstrap_form', github: 'bootstrap-ruby/rails-bootstrap-forms', branch: 'master'
gem 'cancancan', '~> 2.0.0'
gem 'devise', '~> 4.7.1'
gem 'groupdate', '~> 3.2.0'
gem 'haml', '~> 5.0.4'
gem 'jbuilder', '~> 2.5'
gem 'jwt', '~> 2.1.0'
# gem 'mysql2', '~> 0.4.5'
gem 'nokogiri', '~> 1.10.8'
gem 'pg', '~> 1.1.4'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.1.6'
# gem 'sass-rails', '~> 5.0'
gem 'sassc-rails', '~> 2.1.2'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
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
