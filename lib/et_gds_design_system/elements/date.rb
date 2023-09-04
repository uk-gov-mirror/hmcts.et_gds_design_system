module EtGdsDesignSystem
  module Elements
    class Date < ::GOVUKDesignSystemFormBuilder::Elements::Date
      SEGMENTS = { day: '3', month: '2', year: '1' }.freeze
      private

      def value(segment)
        attribute = @builder.object.try(@attribute_name)
        attribute ||= @builder.object.read_attribute_before_type_cast(@attribute_name)

        return unless attribute

        if attribute.respond_to?(segment)
          attribute.send(segment)
        elsif attribute.respond_to?(:fetch)
          attribute.fetch(MULTIPARAMETER_KEY[segment]) do
            warn("No key '#{segment}' found in MULTIPARAMETER_KEY hash. Expected to find #{MULTIPARAMETER_KEY.values}")

            nil
          end
        else
          raise(ArgumentError,
                'invalid Date-like object: must be a Date, Time, DateTime or Hash in MULTIPARAMETER_KEY format')
        end
      end

      def id(segment, link_errors)
        if has_errors? && link_errors
          field_id(link_errors: link_errors)
        else
          [@object_name, @attribute_name, SEGMENTS.fetch(segment)].join("_")
        end
      end

      def name(segment)
        format(
          "%<object_name>s[%<input_name>s(%<segment>s)]",
          object_name: @object_name,
          input_name: @attribute_name,
          segment: SEGMENTS.fetch(segment)
        )
      end
    end
  end
end
