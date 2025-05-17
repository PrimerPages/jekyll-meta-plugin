# frozen_string_literal: true

# spec/your_gem/version_spec.rb
require 'spec_helper'
require 'your_gem/version'

RSpec.describe YourGem do
  it 'has a VERSION constant' do
    expect(YourGem::VERSION).not_to be_nil
  end

  it 'has a non-empty VERSION string' do
    expect(YourGem::VERSION).to be_a(String)
  end
end
