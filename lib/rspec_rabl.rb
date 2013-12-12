require 'rspec'
RSpec.configure do |c|
  c.add_setting :rabl_configuration
end

module RSpec
  module Rabl
  end
end
require "rspec_rabl/version"
require 'rspec/rabl/example_group'
require 'rspec/rabl/helpers'
