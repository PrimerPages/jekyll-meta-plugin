# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name           = 'jekyll-meta'
  spec.version        =  File.read(File.expand_path('VERSION', __dir__)).strip
  spec.authors        = ['Allison Thackston']
  spec.email          = ['allison@allisonthackston.com']

  spec.summary        = 'Expose Jekyll version and build metadata to Liquid templates.'
  spec.description    = 'A Jekyll plugin that injects metadata into the `site.meta` namespace.'
  spec.homepage       = 'https://github.com/PrimerPages/jekyll-meta'
  spec.license        = 'MIT'
  spec.metadata       = {
    'source_code_uri' => spec.homepage,
    'bug_tracker_uri' => "#{spec.homepage}/issues",
    'rubygems_mfa_required' => 'true'
  }

  spec.files          = Dir['lib/**/*.rb', 'README.md', 'LICENSE', 'VERSION']
  spec.require_paths  = ['lib']

  spec.required_ruby_version = '>= 2.7'
  spec.add_dependency 'jekyll', '>= 3.0', '< 5.0'
end
