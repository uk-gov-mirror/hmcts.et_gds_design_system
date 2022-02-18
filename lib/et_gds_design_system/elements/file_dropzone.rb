require 'govuk_design_system_formbuilder/base'
require 'govuk_design_system_formbuilder/refinements/prefixable_array'
require 'govuk_design_system_formbuilder/traits/error'
require 'govuk_design_system_formbuilder/traits/hint'
require 'govuk_design_system_formbuilder/traits/label'
require 'govuk_design_system_formbuilder/traits/supplemental'
require 'govuk_design_system_formbuilder/traits/html_attributes'
require 'govuk_design_system_formbuilder/containers/form_group'
module EtGdsDesignSystem
  module Elements
    class FileDropzone < ::GOVUKDesignSystemFormBuilder::Base
      using ::GOVUKDesignSystemFormBuilder::PrefixableArray

      include ::GOVUKDesignSystemFormBuilder::Traits::Error
      include ::GOVUKDesignSystemFormBuilder::Traits::Hint
      include ::GOVUKDesignSystemFormBuilder::Traits::Label
      include ::GOVUKDesignSystemFormBuilder::Traits::Supplemental
      include ::GOVUKDesignSystemFormBuilder::Traits::HTMLAttributes

      def initialize(builder, object_name, attribute_name, hint:, label:, button_text: nil, remove_file_button_text: nil, caption:, form_group:, accepted_files: nil, type: nil, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @label = label
        @caption = caption
        @hint = hint
        @html_attributes = kwargs
        @form_group = form_group
        @accepted_files = accepted_files
        @button_text = button_text
        @remove_file_button_text = remove_file_button_text
      end

      def html
        ::GOVUKDesignSystemFormBuilder::Containers::FormGroup.new(*bound, **@form_group).html do
          safe_join([label_element, supplemental_content, hint_element, error_element, file])
        end
      end

      private

      def file
        tag.div(class: 'dropzone',
                data: {
                  module: 'et-gds-design-system-dropzone-uploader',
                  attribute_name: @attribute_name,
                  remove_file_button_text: @remove_file_button_text,
                  type: @type,
                  accepted_files: @accepted_files&.join(',')
                }) do
          safe_join [
                      tag.div(class: 'dz-message grid-row') do
                        safe_join [
                                    tag.div(class: 'column-one-third arrow-icon') do
                                      tag.p
                                    end,
                                    tag.div(class: 'column-one-half') do
                                      tag.button(type: 'button', class: 'govuk-button govuk-button--secondary', data: { 'auto-hide': true }) do
                                        @button_text
                                      end if @button_text
                                    end
                                  ]
                      end,
                      @builder.fields_for(@attribute_name) do |f|
                        safe_join [
                                    f.hidden_field(:path, data: { submit_key: 'path' }),
                                    f.hidden_field(:filename, data: { submit_key: 'filename' }),
                                    f.hidden_field(:content_type, data: { submit_key: 'content_type' })
                                  ]
                      end
          ]
        end
      end
    end
  end
end
