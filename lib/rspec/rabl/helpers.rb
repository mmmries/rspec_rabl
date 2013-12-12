module RSpec
  module Rabl
    module Helpers
      def rabl_data(opts = {},&block)
        let(:_rabl_opts){ opts }
        let(:_rabl_data, &block)
      end

      def rabl_template(&block)
        let(:_rabl_template, &block)
      end

      def view_path(relative_path)
        let(:_view_path) { relative_path }
      end

      def rabl_config(local_config)
        let(:_rabl_config) { RSpec.configuration.rabl_configuration.merge(local_config) }
      end
    end
  end
end
