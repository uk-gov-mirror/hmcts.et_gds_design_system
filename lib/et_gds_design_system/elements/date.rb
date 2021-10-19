module EtGdsDesignSystem
  module Elements
    class Date < ::GOVUKDesignSystemFormBuilder::Elements::Date
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
          fail(ArgumentError, "invalid Date-like object: must be a Date, Time, DateTime or Hash in MULTIPARAMETER_KEY format")
        end
      end
    end
  end
end