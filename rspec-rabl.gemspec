# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/rabl/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-rabl"
  spec.version       = RSpec::Rabl::VERSION
  spec.authors       = ["Michael Ries"]
  spec.email         = ["michael@riesd.com"]
  spec.description   = "Provides a more declarative form of view testing for users of rabl"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/mmmries/rspec_rabl"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry-nav"
  spec.add_runtime_dependency "rspec" , "~> 3.0"
  spec.add_runtime_dependency "rabl", "~> 0.9"
end
