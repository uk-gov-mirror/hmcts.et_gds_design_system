# frozen_string_literal: true

require 'govuk_design_system_formbuilder'
require 'et_gds_design_system/elements/date'
require 'et_gds_design_system/elements/file_dropzone'
require 'et_gds_design_system/deprecator'
module EtGdsDesignSystem
  module Form
    class Builder < SimpleDelegator
      LABEL_DEFAULTS = { size: 's' }.freeze
      FIELDSET_LABEL_DEFAULTS = { size: 'm' }
      CHECK_BOX_LABEL_DEFAULTS = { size: nil }
      HINT_DEFAULTS = {}.freeze
      OPTIONAL_I18N_KEY = 'shared.optional'

      def initialize(object_name, object, template, options)
        @template = template
        super ::GOVUKDesignSystemFormBuilder::FormBuilder.new(object_name, object, template, options)
      end

      def govuk_date_field(*args, label:, **kw_args)
        super(*args, legend: label, **kw_args)
      end
      deprecate govuk_date_field: 'govuk_date_field is deprecated - please use date_field instead and read the documentation as it makes your code simpler', deprecator: EtGdsDesignSystem::Deprecator

      def date_field(attribute, *_args, label: true, hint: true, optional: false, caption: {}, date_of_birth: false,
                     omit_day: false, form_group: {}, wildcards: false, maxlength_enabled: false, **kw_args, &block)
        Elements::Date.new(self, object_name, attribute,
                           hint: normalize_hint(attribute, hint), legend: normalize_label(attribute, label, optional), caption: caption, date_of_birth: date_of_birth, omit_day: omit_day, form_group: form_group, wildcards: wildcards, maxlength_enabled: maxlength_enabled, **kw_args, &block).html
      end

      def govuk_collection_radio_buttons(*args, label:, **kw_args)
        super(*args, legend: label, **kw_args)
      end
      deprecate govuk_collection_radio_buttons: 'govuk_collection_radio_buttons is deprecated - please use collection_radio_buttons instead and read the documentation as it makes your code simpler', deprecator: EtGdsDesignSystem::Deprecator

      def collection_radio_buttons(attribute, collection = i18n_options_for(attribute), key_method = :first,
                                   value_method = :last, *args, label: true, hint: true, optional: false, include_hidden: false, **kw_args)
        __getobj__.govuk_collection_radio_buttons(attribute, collection, key_method, value_method, *args,
                                                  legend: normalize_label(attribute, label, optional), hint: normalize_hint(attribute, hint), include_hidden: include_hidden, **kw_args)
      end

      def collection_select(attribute, collection = i18n_options_for(attribute), key_method = :first,
                            value_method = :last, *args, label: true, hint: true, optional: false, **kw_args)
        __getobj__.govuk_collection_select(attribute, collection, key_method, value_method, *args,
                                           label: normalize_label(attribute, label, optional), hint: normalize_hint(attribute, hint), class: 'govuk-!-width-two-thirds', **kw_args)
      end
      deprecate govuk_collection_select: 'govuk_collection_select is deprecated - please use collection_select instead and read the documentation as it makes your code simpler', deprecator: EtGdsDesignSystem::Deprecator

      def govuk_collection_check_boxes(*args, label:, **kw_args)
        super(*args, legend: label, **kw_args)
      end
      deprecate govuk_collection_check_boxes: 'govuk_collection_check_boxes is deprecated - please use collection_check_boxes instead and read the documentation as it makes your code simpler', deprecator: EtGdsDesignSystem::Deprecator

      def collection_check_boxes(attribute, collection = i18n_options_for(attribute), key_method = :first,
                                 value_method = :last, *args, label: true, hint: true, optional: false, **kw_args)
        __getobj__.govuk_collection_check_boxes(attribute, collection, key_method, value_method, *args,
                                                legend: normalize_label(attribute, label, optional), hint: normalize_hint(attribute, hint), **kw_args)
      end

      def check_boxes_fieldset(attribute_name, label: true, caption: {}, hint: true, small: false, classes: nil,
                               form_group: {}, multiple: true, optional: false, include_hidden: true, &block)
        __getobj__.govuk_check_boxes_fieldset(attribute_name,
                                              legend: normalize_label(attribute_name, label, optional), caption: caption, hint: normalize_hint(attribute_name, hint), small: small, classes: classes, form_group: form_group, multiple: multiple, &block)
      end

      def singular_check_box(attribute_name, value: true, unchecked_value: false, fieldset_label: true,
                             fieldset_caption: {}, fieldset_hint: true, optional: false, include_hidden: true, label: fieldset_label, hint: false)
        check_boxes_fieldset(attribute_name, multiple: false, label: fieldset_label, hint: fieldset_hint,
                                             include_hidden: include_hidden) do
          result = []
          result << __getobj__.hidden_field(attribute_name, value: unchecked_value) if include_hidden
          result << check_box(attribute_name, value, unchecked_value, multiple: false,
                                                                      label: normalize_check_box_label(attribute_name, label, optional), hint: hint)
          safe_join(result)
        end
      end

      def govuk_fieldset(*args, label:, **kw_args)
        super(*args, legend: label, **kw_args)
      end

      def fieldset(*args, label:, **kw_args, &block)
        __getobj__.govuk_fieldset(*args, legend: normalize_fieldset_label(nil, label, false), **kw_args, &block)
      end

      def govuk_email_field(*args, **kw_args)
        super(*args, spellcheck: false, **kw_args)
      end
      deprecate govuk_email_field: 'govuk_email_field is deprecated - please use email_field instead and read the documentation as it makes your code simpler', deprecator: EtGdsDesignSystem::Deprecator

      def email_field(attribute, *args, label: true, hint: true, width: 'two-thirds', optional: false, **kw_args)
        __getobj__.govuk_email_field(attribute, *args, label: normalize_label(attribute, label, optional),
                                                       hint: normalize_hint(attribute, hint), width: width, **kw_args)
      end

      def govuk_phone_field(*args, **kw_args)
        super(*args, autocomplete: 'tel', **kw_args)
      end
      deprecate govuk_phone_field: 'govuk_phone_field is deprecated - please use phone_field instead and read the documentation as it makes your code simpler', deprecator: EtGdsDesignSystem::Deprecator

      def phone_field(attribute, *args, label: true, hint: true, width: 'two-thirds', optional: false, **kw_args)
        __getobj__.govuk_phone_field(attribute, *args, label: normalize_label(attribute, label, optional),
                                                       hint: normalize_hint(attribute, hint), width: width, **kw_args)
      end

      def govuk_text_field(attribute, *args, label: true, hint: true, width: 'two-thirds', optional: false, **kw_args)
        super(attribute, *args, label: normalize_label(attribute, label,
                                                       optional), hint: normalize_hint(attribute,
                                                                                       hint), width: width, **kw_args)
      end
      deprecate govuk_text_field: 'govuk_text_field is deprecated - please use text_field instead and read the documentation as it makes your code simpler', deprecator: EtGdsDesignSystem::Deprecator

      def text_field(attribute, *args, label: true, hint: true, width: 'two-thirds', optional: false, **kw_args)
        __getobj__.govuk_text_field(attribute, *args, label: normalize_label(attribute, label, optional),
                                                      hint: normalize_hint(attribute, hint), width: width, **kw_args)
      end

      def text_area(attribute, *args, label: true, hint: true, optional: false, **kw_args)
        __getobj__.govuk_text_area(attribute, *args, label: normalize_label(attribute, label, optional),
                                                     hint: normalize_hint(attribute, hint), **kw_args)
      end
      deprecate govuk_text_area: 'govuk_text_area is deprecated - please use text_area instead and read the documentation as it makes your code simpler', deprecator: EtGdsDesignSystem::Deprecator

      def file_field(attribute, *args, label: true, hint: true, optional: false, **kw_args)
        __getobj__.govuk_file_field(attribute, *args, label: normalize_label(attribute, label, optional),
                                                      hint: normalize_hint(attribute, hint), **kw_args)
      end
      deprecate govuk_file_field: 'govuk_file_field is deprecated - please use file_field instead and read the documentation as it makes your code simpler', deprecator: EtGdsDesignSystem::Deprecator

      def file_dropzone_field(attribute, *_args, label: true, hint: true, optional: false, upload_button: true,
                              remove_file_button: true, file_selected_text: true, caption: {}, form_group: {}, accepted_files: nil, type: 'text/csv', **kw_args)
        Elements::FileDropzone.new(self,
                                   object_name,
                                   attribute, hint: normalize_hint(attribute, hint),
                                              label: normalize_label(attribute, label, optional),
                                              button_text: normalize_text_argument(attribute, upload_button, 'button_text'),
                                              remove_file_button_text: normalize_text_argument(attribute, remove_file_button, 'remove_file_button_text'),
                                              file_selected_text: normalize_text_argument(attribute, file_selected_text, 'file_selected_text'),
                                              caption: caption,
                                              form_group: form_group,
                                              accepted_files: accepted_files,
                                              type: type,
                                              template: template,
                                              **kw_args).html
      end

      def check_box(attribute, *args, label: true, hint: true, optional: false, **kw_args)
        __getobj__.govuk_check_box(attribute, *args, label: normalize_check_box_label(attribute, label, optional),
                                                     hint: normalize_hint(attribute, hint), **kw_args)
      end
      deprecate govuk_check_box: 'govuk_check_box is deprecated - please use check_box instead and read the documentation as it makes your code simpler', deprecator: EtGdsDesignSystem::Deprecator

      def submit(*args, **kw_args)
        __getobj__.govuk_submit(*args, **kw_args)
      end

      def revealed_content(attribute, values:, classes: [], multiple: false, tag: 'div', &block)
        # div data-reveal-on-selector='input[name="employment[current_situation]"]' data-reveal-on-value="still_employed"
        name = "#{__field_name_for(attribute)}#{multiple ? '[]' : ''}"
        content_tag tag, class: classes, data: {
          'reveal-on-selector': "input[name=\"#{name}\"]",
          'reveal-on-value': values.to_json,
          'module': 'et-gds-design-system-reveal-on-radio-button'
        } do
          capture(&block)
        end
      end

      private

      attr_reader :template

      def __field_name_for(attribute)
        text_input = capture do
          text_field(attribute, label: false, hint: false)
        end
        text_input.match(/name="(.*?)"/)[1]
      end

      def normalize_label(attribute, label, optional)
        case label
        when String then LABEL_DEFAULTS.merge(text: __with_optional(label, optional))
        when Hash then LABEL_DEFAULTS.merge(optional ? label.merge(text: __with_optional(label[:text],
                                                                                         optional)) : label)
        when FalseClass then { text: false }
        when TrueClass then LABEL_DEFAULTS.merge(text: __with_optional(@template.t(".#{attribute}.label"), optional))
        else label
        end
      end

      def normalize_check_box_label(attribute, label, optional)
        case label
        when String then CHECK_BOX_LABEL_DEFAULTS.merge(text: __with_optional(label, optional))
        when Hash then CHECK_BOX_LABEL_DEFAULTS.merge(optional ? label.merge(text: __with_optional(label[:text],
                                                                                                   optional)) : label)
        when FalseClass then { text: false }
        when TrueClass then CHECK_BOX_LABEL_DEFAULTS.merge(text: __with_optional(@template.t(".#{attribute}.label"),
                                                                                 optional))
        else label
        end
      end

      def normalize_fieldset_label(attribute, label, optional)
        case label
        when String then FIELDSET_LABEL_DEFAULTS.merge(text: __with_optional(label, optional))
        when Hash then FIELDSET_LABEL_DEFAULTS.merge(optional ? label.merge(text: __with_optional(label[:text],
                                                                                                  optional)) : label)
        when FalseClass then { text: false }
        when TrueClass then FIELDSET_LABEL_DEFAULTS.merge(text: __with_optional(@template.t(".#{attribute}.label"),
                                                                                optional))
        else label
        end
      end

      def normalize_hint(attribute, hint)
        case hint
        when String then HINT_DEFAULTS.merge(text: hint)
        when Hash then HINT_DEFAULTS.merge(hint)
        when TrueClass then __hint_hash(attribute)
        when FalseClass then { text: false }
        else hint
        end
      end

      def normalize_text_argument(attribute, arg, i18n_key)
        case arg
        when TrueClass then @template.t(".#{attribute}.#{i18n_key}", raise: true)
        when FalseClass then nil
        else arg
        end
      rescue I18n::MissingTranslationData
        nil
      end

      def __hint_hash(attribute)
        hint_text = __hint_text(attribute)
        return {} if hint_text.nil?

        HINT_DEFAULTS.merge(text: hint_text)
      end

      def __hint_text(attribute)
        @template.t(".#{attribute}.hint", raise: true)
      rescue I18n::MissingTranslationData
        nil
      end

      def __upload_button_text(attribute)
        @template.t(".#{attribute}.button_text", raise: true)
      rescue I18n::MissingTranslationData
        nil
      end

      def __with_optional(label_text, optional)
        return label_text if label_text.nil? || !optional

        "#{label_text} #{@template.t(OPTIONAL_I18N_KEY)}"
      end

      def i18n_options_for(attribute)
        @template.t(".#{attribute}.options").to_a.map do |item|
          item[0] = item[0].to_s
          item
        end
      end
    end
  end
end
