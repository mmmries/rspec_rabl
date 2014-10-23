module RSpec
  module Rabl
    module ExampleGroup
      def parsed_json
        JSON.parse(rendered_template)
      end

      def rendered_template
        renderer.render
      end

      def renderer
        @renderer ||= ::Rabl::Renderer.new(
          _rabl_template.gsub('.rabl',''),
          _rabl_data,
          :view_path => _rabl_config[:view_paths],
        )
      end

      def subject
        renderer
      end

      private
      def _rabl_config
        RSpec.configuration.rabl_configuration
      end

      def _rabl_data
        nil
      end

      def _rabl_opts
        {}
      end

      def _rabl_template
        RSpec.current_example.metadata[:example_group][:description]
      end
    end
  end
end
