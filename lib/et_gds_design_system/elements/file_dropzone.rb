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

      def initialize(builder, object_name, attribute_name, hint:, label:, caption:, form_group:, template:, button_text: nil,
                     remove_file_button_text: nil, file_selected_text: nil, accepted_files: nil, type: nil, create_blob_url: nil, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @label = label
        @caption = caption
        @hint = hint
        @html_attributes = kwargs
        @form_group = form_group
        @accepted_files = accepted_files
        @button_text = button_text
        @remove_file_button_text = remove_file_button_text
        @file_selected_text = file_selected_text
        @template = template
        @create_blob_url = create_blob_url
      end

      def html
        ::GOVUKDesignSystemFormBuilder::Containers::FormGroup.new(*bound, **@form_group).html do
          safe_join([label_element, supplemental_content, hint_element, error_element, file])
        end
      end

      private

      attr_reader :template

      def file
        template.render partial: 'et_gds_design_system/elements/file_dropzone/template',
                        locals: {
                          id: field_id(link_errors: true),
                          attribute_name: @attribute_name,
                          remove_file_button_text: @remove_file_button_text,
                          button_text: @button_text,
                          file_selected_text: @file_selected_text,
                          type: @type,
                          accepted_files: @accepted_files,
                          create_blob_url: @create_blob_url,
                          builder: @builder
                        }
      end
    end
  end
end
