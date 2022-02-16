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

      def initialize(builder, object_name, attribute_name, hint:, label:, caption:, form_group:, accepted_files: nil, type: nil, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @label = label
        @caption = caption
        @hint = hint
        @html_attributes = kwargs
        @form_group = form_group
        @accepted_files = accepted_files
      end

      def html
        ::GOVUKDesignSystemFormBuilder::Containers::FormGroup.new(*bound, **@form_group).html do
          safe_join([label_element, supplemental_content, hint_element, error_element, file])
        end
      end

      private

      def file
        form_id = "dummyid"
        tag.div(class: 'dropzone',
                id: form_id,
                data: {
                  module: 'et-gds-design-system-dropzone-uploader',
                  form_id: form_id,
                  upload_key_id: 'dummy_upload_key_id',
                  file_name_id: 'additional_claimants_upload_upload_file_name',
                  type: @type,
                  accepted_files: @accepted_files&.join(',')
                }) do
          safe_join [
                      tag.div(class: 'dz-default dz-message grid-row') do
                        safe_join [
                                    tag.div(class: 'column-one-third arrow-icon') do
                                      tag.p
                                    end,
                                    tag.div(class: 'column-one-half') do
                                      safe_join [
                                                  tag.span(class: 'normal') do
                                                    "drag text goes here"
                                                  end,
                                                  tag.div(class: 'bold-normal') do
                                                    "OR text"
                                                  end,
                                                  # @TODO Remove hard coded id
                                                  tag.button(class: 'button button-secondary', id: 'upload-button') do
                                                    "Upload button text goes here"
                                                  end
                                                ]
                                    end
                                  ]
                      end,
                      @builder.hidden_field(:upload_additional_information),
                      @builder.hidden_field(:upload_file_name)

          ]
        end
      end
    end
  end
end
