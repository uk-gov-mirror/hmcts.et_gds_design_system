module EtGdsDesignSystem
  class AzureFile < ActiveModel::Type::Value
    private

    def cast_value(value)
      unless value.is_a?(Hash) && value['filename'].present? && value['path'].present? && value['content_type'].present?
        return nil
      end

      value
    end
  end
end
