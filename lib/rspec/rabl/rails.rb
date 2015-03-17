::RSpec.configure do |config|
  config.include ::RSpec::Rabl::Matchers, :example_group => ->(group,metadata){ group[:file_path].start_with?("./spec/views") }
  config.include ::RSpec::Rabl::ExampleGroup, :example_group => ->(group,metadata){ group[:file_path].start_with?("./spec/views") }
  config.rabl_configuration = {:view_paths => ['app/views']}
  config.extend ::RSpec::Rabl::Helpers
end
