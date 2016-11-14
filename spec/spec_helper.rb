require 'bundler/setup'
require 'json'
require 'pry-nav'
require 'rabl'
require 'rspec'
require 'rspec/rabl'

require 'support/user_context'
require 'support/renderer_scope_helper'

RSpec.configure do |c|
  c.order = :rand
  c.include RSpec::Rabl::ExampleGroup
  c.rabl_configuration = {:view_paths => 'spec/fixtures'}
end

include RSpec::Rabl::Helpers
