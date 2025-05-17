# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'jekyll', ENV['JEKYLL_VERSION'] if ENV['JEKYLL_VERSION']

group :development, :test do
  gem 'rspec'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

# Required in Ruby 3.4+ when Jekyll < 4.4
gem 'base64'
gem 'bigdecimal'
gem 'csv'
gem 'logger'

# Required in Ruby 3.3.4 when Jekyll == 3.10
gem 'kramdown-parser-gfm'
