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
        if implicit_nil_value?
          "nil value when testing.\n expected #{expected_value.inspect} in #{attribute_path}\n  got #{rendered_value.inspect}\n If you want to test for a nil value, please use `with_value(nil)`"
        else
          "expected #{expected_value.inspect} in #{attribute_path}\n  got #{rendered_value.inspect}"
        end
      end

      def matches?(subject)
        @subject = subject
        attribute_rendered? && (!expected_value_set || rendered_value == expected_value) && !implicit_nil_value?
      end

      def implicit_nil_value?
        return false if expected_value_set
        rendered_value.nil? || expected_value.nil?
      end

      def with(model_attribute)
        @model_attribute = model_attribute
        self
      end

      def with_value(expected_value)
        @expected_value_set = true
        @expected_value = expected_value
        self
      end

      private
      attr_reader :rendered_attribute, :subject, :opts, :expected_value_set

      def attribute_path
        @attribute_path ||= begin
          path = ""
          path << "[\"#{opts[:root]}\"]" if opts[:root]
          path << "[\"#{opts[:object_root]}\"]" if opts[:object_root]
          path << "[\"#{rendered_attribute}\"]"
        end
      end

      def model_attribute
        @model_attribute ||= rendered_attribute
      end

      # The expected value may be set to nil or false. Retrieving the value from the rendered object
      # will then fail if the attribute is calculated from a node
      def expected_value
        @expected_value ||= @expected_value_set ? @expected_value : get_attribute_from_rendered_object
      end

      def rendered_value
        parsed_object[rendered_attribute.to_s]
      end

      def rendered_object
        subject.object
      end

      def attribute_rendered?
        parsed_object.key?(rendered_attribute.to_s)
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
