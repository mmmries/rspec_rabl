module RSpec
  module Rabl
    class AttributeMatcher
      def initialize(rendered_attribute, opts = {})
        @rendered_attribute = rendered_attribute
        @opts = opts
      end

      def description
        "render the #{rendered_attribute} attribute"
      end

      def failure_message
        "expected #{parsed} to render #{rendered_attribute} = #{expected_value}"
      end

      def matches?(subject)
        @subject = subject
        attribute_rendered? && rendered_value == expected_value
      end

      def with(model_attribute)
        @model_attribute = model_attribute
        self
      end

      def with_value(expected_value)
        @expected_value = expected_value
        self
      end

      private
      attr_reader :rendered_attribute, :subject, :opts

      def model_attribute
        @model_attribute ||= rendered_attribute
      end

      def expected_value
        @expected_value ||= get_attribute_from_rendered_object
      end

      def rendered_value
        parsed_object[rendered_attribute.to_s]
      end

      def rendered_object
        subject.object
      end

      def attribute_rendered?
        parsed_object.has_key?(rendered_attribute.to_s)
      end

      def get_attribute_from_rendered_object
        if collection?
          rendered_object.first.public_send(model_attribute)
        else
          rendered_object.public_send(model_attribute)
        end
      end

      def collection?
        rendered_object.is_a?(Array)
      end

      def parsed_object
        collection? ? parse_collection_object : parse_object
      end

      def parse_collection_object
        data = parsed
        if opts[:root]
          data = data.fetch(opts[:root]){ raise ::RSpec::Rabl::Error.new("Missing Root #{opts[:root]}") }
        end
        data = data.first
        if opts[:object_root]
          data = data.fetch(opts[:object_root]){ raise ::RSpec::Rabl::Error.new("Missing Object Root #{opts[:object_root]}") }
        end
        data
      end

      def parse_object
        if opts[:root]
          parsed.fetch(opts[:root]){ raise ::RSpec::Rabl::Error.new("Missing Object Root") }
        else
          parsed
        end
      end

      def parsed
        @parsed ||= JSON.parse(subject.render)
      end
    end
  end
end
