module EtGdsDesignSystem
  class AzureFile < ActiveModel::Type::Value
    private

    def cast_value(value)
      return nil unless value.is_a?(Hash) && value['filename'].present? && value['path'].present? && value['content_type'].present?

      value
    end
  end
end
