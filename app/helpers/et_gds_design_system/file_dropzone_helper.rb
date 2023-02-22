module EtGdsDesignSystem
  module FileDropzoneHelper
    def hidden_field_for(key, form_builder:, attribute_name:, builder:)
      attribute_value = builder.object.send(attribute_name)
      options = { data: { submit_key: key.to_s } }
      options[:value] = attribute_value[key.to_s] unless attribute_value.nil? || attribute_value[key.to_s].nil?
      form_builder.hidden_field(key, options)
    end
  end
end
