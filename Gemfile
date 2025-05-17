# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'jekyll', ENV['JEKYLL_VERSION'] if ENV['JEKYLL_VERSION']

group :development, :test do
  gem 'rspec'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end
