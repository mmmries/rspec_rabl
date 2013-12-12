module RSpec::Rabl
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
    def _rabl_template
      example.metadata[:example_group][:description]
    end

    def _rabl_config
      RSpec.configuration.rabl_configuration
    end

    def _rabl_data
      nil
    end
  end

  module Helpers
    def rabl_data(&block)
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


#matches?(subject)
  # attribute
#  parsed[attribute] && parsed[attribute] == subject.object.__send__(attribute)
#end
