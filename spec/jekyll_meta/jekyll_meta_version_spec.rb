# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/jekyll_meta'

RSpec.describe JekyllMeta do
  it 'has a VERSION constant' do
    expect(JekyllMeta::VERSION).not_to be_nil
  end

  it 'has a non-empty VERSION string' do
    expect(JekyllMeta::VERSION).to be_a(String)
  end
end
