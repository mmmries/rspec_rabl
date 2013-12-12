module RSpec
  module Rabl
    module Matchers
      def render_attribute(attribute)
        AttributeMatcher.new(attribute, _rabl_opts)
      end
    end
  end
end
