# frozen_string_literal: true

require_relative 'lib/your_gem/version'

Gem::Specification.new do |spec|
  spec.name          = 'your-gem-name'
  spec.version       = YourGem::VERSION
  spec.authors       = ['Your Name']
  spec.email         = ['your@email.com']

  spec.summary       = "Short summary of your gem's purpose."
  spec.description   = "A longer description of what your gem does and why it's useful."
  spec.homepage      = 'https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPO'
  spec.license       = 'MIT'

  spec.metadata = {
    'source_code_uri' => spec.homepage,
    'bug_tracker_uri' => "#{spec.homepage}/issues",
    'rubygems_mfa_required' => 'true'
  }

  spec.files = Dir['lib/**/*.rb', 'README.md', 'LICENSE', 'spec/fixtures/**/*']
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.7'

  spec.add_dependency 'jekyll', '>= 3.0', '< 5.0'
end
