# frozen_string_literal: true
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'bootstrap_form', github: 'bootstrap-ruby/rails-bootstrap-forms', branch: 'bootstrap-v4'
gem 'cancancan'
gem 'coffee-rails', '~> 4.2'
gem 'devise', github: 'plataformatec/devise'
gem 'font-awesome-rails', '~> 4.7.0'
gem 'jbuilder', '~> 2.5'
gem 'mysql2'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.0'
# gem 'sass-rails', '~> 5.0'
gem 'sassc-rails', '~> 1.3.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'will_paginate-bootstrap4'

source 'https://rails-assets.org' do
  gem 'rails-assets-jquery', '>= 3.2.1'
  gem 'rails-assets-tether', '>= 1.3.3'
end

group :development, :test do
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller'
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rails', '~> 1.2'
  gem 'faker'
  gem 'pry-rails'
  gem 'rubocop', '~> 0.47.1', require: false
end

group :development do
  gem 'listen', '~> 3.0.5'
end
