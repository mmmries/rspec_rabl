require 'bundler/setup'
require 'json'
require 'pry-nav'
require 'rabl'
require 'rspec'
require 'rspec_rabl'

RSpec.configure do |c|
  c.order = :rand
  c.color = :true
  c.include RSpec::Rabl::ExampleGroup
  c.rabl_configuration = {:view_paths => 'spec/fixtures'}
end

include RSpec::Rabl::Helpers
