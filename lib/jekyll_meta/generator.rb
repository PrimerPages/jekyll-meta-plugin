# frozen_string_literal: true

module JekyllMeta
  # A Jekyll plugin that injects build metadata into the site configuration.
  #
  # This generator runs with the highest priority and safely adds useful
  # environment details—such as Jekyll version, Ruby version, and build
  # environment—into `site.config['meta']` for later use in templates or plugins.
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      site.config['meta'] ||= {}
      site.config['meta'].merge!(
        'jekyll_version' => Jekyll::VERSION,
        'jekyll_major_version' => Jekyll::VERSION.split('.').first.to_i,
        'environment' => Jekyll.env,
        'ruby_version' => RUBY_VERSION
      )
    end
  end
end
