::RSpec.configure do |config|
  config.include ::RSpec::Rabl::Matchers, :file_path => %r(spec/views)
  config.include ::RSpec::Rabl::ExampleGroup, :file_path => %r(spec/views)
  config.rabl_configuration = {:view_paths => ['app/views']}
  config.extend ::RSpec::Rabl::Helpers
end
