require 'rspec'
require "rspec_rabl/version"
require "rspec/rabl/error"

# helpers to access the rendered template and parsed template
require 'rspec/rabl/example_group'
# helpers that can be called outside an it block to configure data and settings
require 'rspec/rabl/helpers'
# custom matchers
require 'rspec/rabl/attribute_matcher'
# helpers for invoking the custom matchers
require 'rspec/rabl/matchers'

RSpec.configure do |c|
  c.add_setting :rabl_configuration
  c.include RSpec::Rabl::Matchers
end
