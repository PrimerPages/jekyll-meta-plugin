# frozen_string_literal: true

require 'jekyll'
require_relative '../../lib/jekyll_meta/generator'

RSpec.shared_context 'when a jekyll site is set up' do
  let(:source_dir) { File.expand_path('../fixtures', __dir__) }
  let(:dest_dir) { File.join(source_dir, '../fixtures/_site') }

  let(:site_config) do
    Jekyll.configuration(
      'source' => source_dir,
      'destination' => dest_dir,
      'quiet' => true
    )
  end

  let(:site) { Jekyll::Site.new(site_config) }

  def build_site!
    site.reset
    site.read
    described_class.new.generate(site)
    site.render
    site.write
  end
end

RSpec.describe JekyllMeta::Generator do
  include_context 'when a jekyll site is set up'

  before { build_site! }

  describe "site.config['meta']" do
    it 'is not nil' do
      expect(site.config['meta']).not_to be_nil
    end

    it 'includes jekyll_version' do
      expect(site.config['meta']['jekyll_version']).to eq(Jekyll::VERSION)
    end
  end

  it 'adds jekyll_major_version' do
    expect(site.config['meta']['jekyll_major_version']).to eq(Jekyll::VERSION.split('.').first.to_i)
  end

  it 'adds ruby_version' do
    expect(site.config['meta']['ruby_version']).to eq(RUBY_VERSION)
  end

  it 'adds environment' do
    expect(site.config['meta']['environment']).to eq(Jekyll.env)
  end

  describe 'rendered output' do
    let(:output_file) { File.join(dest_dir, 'index.html') }
    let(:html) { File.read(output_file) }

    it 'writes the output file' do
      expect(File.exist?(output_file)).to be true
    end

    it 'renders jekyll_version in output' do
      expect(html).to include("jekyll_version: #{Jekyll::VERSION}")
    end

    it 'renders jekyll_major_version in output' do
      expect(html).to include("jekyll_major_version: #{Jekyll::VERSION.split('.').first}")
    end

    it 'renders ruby_version in output' do
      expect(html).to include("ruby_version: #{RUBY_VERSION}")
    end

    it 'renders environment in output' do
      expect(html).to include("environment: #{Jekyll.env}")
    end
  end
end
