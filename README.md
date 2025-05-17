# jekyll-meta

[![RubyGem Version](https://badge.fury.io/rb/jekyll-meta.svg)](https://badge.fury.io/rb/jekyll-meta)
[![Build Status](https://github.com/PrimerPages/jekyll-meta/actions/workflows/ci.yml/badge.svg)](https://github.com/PrimerPages/jekyll-meta/actions)

A lightweight Jekyll plugin that injects useful build-time metadata (Jekyll version, environment, Ruby version, etc.) into Liquid templates.

## Features

* **Jekyll Version**: `site.meta.jekyll_version`
* **Major Version**: `site.meta.jekyll_major_version` (integer)
* **Environment**: `site.meta.environment` (e.g., `development`, `production`)
* **Ruby Version**: `site.meta.ruby_version`

## Installation

1. **Add to your Gemfile**:

   ```ruby
   group :jekyll_plugins do
     gem "jekyll-meta"
   end
   ```

2. **Bundle install**:

   ```sh
   bundle install
   ```

3. **Enable the plugin** in your `_config.yml`:

   ```yaml
   plugins:
     - jekyll-meta
   ```

4. **Rebuild your site**:

   ```sh
   bundle exec jekyll build
   ```

## Usage

Use the following Liquid variables anywhere in your templates, pages, or posts:

```liquid
Jekyll version: {{ site.meta.jekyll_version }}
Major version: {{ site.meta.jekyll_major_version }}
Environment: {{ site.meta.environment }}
Ruby version: {{ site.meta.ruby_version }}
```

### Example

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>{{ site.title }}</title>
</head>
<body>
  <footer>
    <p>Built with Jekyll v{{ site.meta.jekyll_version }} (v{{ site.meta.jekyll_major_version }})</p>
    <p>Environment: {{ site.meta.environment }}</p>
    <p>Ruby: {{ site.meta.ruby_version }}</p>
  </footer>
</body>
</html>
```

## Configuration

No additional configuration is required. The plugin works out of the box once enabled.

## Compatibility

* **Jekyll**: `>= 3.0`, `< 5.0`
* **Ruby**: `>= 2.7`

## Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a pull request

Please ensure all tests pass and follow the existing code style.

## License

Licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Links

* **Homepage:** [https://github.com/PrimerPages/jekyll-meta](https://github.com/PrimerPages/jekyll-meta)
* **RubyGems:** [https://rubygems.org/gems/jekyll-meta](https://rubygems.org/gems/jekyll-meta)
