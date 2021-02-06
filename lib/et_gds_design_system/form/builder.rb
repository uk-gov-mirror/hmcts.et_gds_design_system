# frozen_string_literal: true

require "govuk_design_system_formbuilder"
module EtGdsDesignSystem
  module Form
    class Builder < SimpleDelegator
      LABEL_DEFAULTS = { size: 's' }.freeze
      HINT_DEFAULTS = {}.freeze
      OPTIONAL_I18N_KEY = 'shared.optional'

      def initialize(object_name, object, template, options)
        @template = template
        super ::GOVUKDesignSystemFormBuilder::FormBuilder.new(object_name, object, template, options)
      end

      def govuk_date_field(*args, label:, **kw_args)
        super(*args, legend: label, **kw_args)
      end
      deprecate govuk_date_field: 'govuk_date_field is deprecated - please use date_field instead and read the documentation as it makes your code simpler'

      def date_field(attribute, *args, label: true, hint: true, optional: false, **kw_args)
        __getobj__.govuk_date_field(attribute, *args, legend: normalize_label(attribute, label, optional), hint: normalize_hint(attribute, hint), **kw_args)
      end

      def govuk_collection_radio_buttons(*args, label:, **kw_args)
        super(*args, legend: label, **kw_args)
      end
      deprecate govuk_collection_radio_buttons: 'govuk_collection_radio_buttons is deprecated - please use collection_radio_buttons instead and read the documentation as it makes your code simpler'

      def collection_radio_buttons(attribute, collection = @template.t(".#{attribute}.options").to_a, key_method = :first, value_method = :last, *args, label: true, hint: true, optional: false, **kw_args)
        __getobj__.govuk_collection_radio_buttons(attribute, collection, key_method, value_method, *args, legend: normalize_label(attribute, label, optional), hint: normalize_hint(attribute, hint), **kw_args)
      end

      def govuk_collection_check_boxes(*args, label:, **kw_args)
        super(*args, legend: label, **kw_args)
      end
      deprecate govuk_collection_check_boxes: 'govuk_collection_check_boxes is deprecated - please use collection_check_boxes instead and read the documentation as it makes your code simpler'

      def collection_check_boxes(attribute, collection = @template.t(".#{attribute}.options").to_a, key_method = :first, value_method = :last, *args, label: true, hint: true, optional: false, **kw_args)
        __getobj__.govuk_collection_check_boxes(attribute, collection, key_method, value_method, *args, legend: normalize_label(attribute, label, optional), hint: normalize_hint(attribute, hint), **kw_args)
      end

      def govuk_fieldset(*args, label:, **kw_args)
        super(*args, legend: label, **kw_args)
      end

      def govuk_email_field(*args, **kw_args)
        super(*args, spellcheck: false, **kw_args)
      end

      def govuk_phone_field(*args, **kw_args)
        super(*args, autocomplete: 'tel', **kw_args)
      end

      def govuk_text_field(attribute, *args, label: true, hint: true, width: 'two-thirds', optional: false, **kw_args)
        super(attribute, *args, label: normalize_label(attribute, label, optional), hint: normalize_hint(attribute, hint), width: width, **kw_args)
      end
      deprecate govuk_text_field: 'govuk_text_field is deprecated - please use text_field instead and read the documentation as it makes your code simpler'

      def text_field(attribute, *args, label: true, hint: true, width: 'two-thirds', optional: false, **kw_args)
        __getobj__.govuk_text_field(attribute, *args, label: normalize_label(attribute, label, optional), hint: normalize_hint(attribute, hint), width: width, **kw_args)
      end

      def text_area(attribute, *args, label: true, hint: true, optional: false, **kw_args)
        __getobj__.govuk_text_area(attribute, *args, label: normalize_label(attribute, label, optional), hint: normalize_hint(attribute, hint), **kw_args)
      end
      deprecate govuk_text_area: 'govuk_text_area is deprecated - please use text_area instead and read the documentation as it makes your code simpler'

      def file_field(attribute, *args, label: true, hint: true, optional: false, **kw_args)
        __getobj__.govuk_file_field(attribute, *args, label: normalize_label(attribute, label, optional), hint: normalize_hint(attribute, hint), **kw_args)
      end
      deprecate govuk_file_field: 'govuk_file_field is deprecated - please use file_field instead and read the documentation as it makes your code simpler'

      def check_box(attribute, *args, label: true, hint: true, optional: false, **kw_args)
        __getobj__.govuk_check_box(attribute, *args, label: normalize_label(attribute, label, optional), hint: normalize_hint(attribute, hint), **kw_args)
      end
      deprecate govuk_check_box: 'govuk_check_box is deprecated - please use check_box instead and read the documentation as it makes your code simpler'

      def revealed_content(attribute, values:, classes: [], multiple: false, &block)
        # div data-reveal-on-selector='input[name="employment[current_situation]"]' data-reveal-on-value="still_employed"
        name = "#{__field_name_for(attribute)}#{multiple ? '[]' : ''}"
        content_tag 'div', class: classes, data: {
          'reveal-on-selector': "input[name=\"#{name}\"]",
          'reveal-on-value': values.to_json,
          'module': 'et-gds-design-system-reveal-on-radio-button'
        } do
          capture(&block)
        end
      end

      private

      def __field_name_for(attribute)
        text_input = capture do
          govuk_text_field(attribute, label: { text: false }, hint: { text: false })
        end
        text_input.match(/name="(.*?)"/)[1]
      end

      def normalize_label(attribute, label, optional)
        case label
        when String then LABEL_DEFAULTS.merge(text: __with_optional(label, optional))
        when Hash then LABEL_DEFAULTS.merge(optional ? label.merge(text: __with_optional(label[:text], optional)) : label)
        when FalseClass then { text: false }
        when TrueClass then LABEL_DEFAULTS.merge(text: __with_optional(@template.t(".#{attribute}.label"), optional))
        else label
        end
      end

      def normalize_hint(attribute, hint)
        case hint
        when String then HINT_DEFAULTS.merge(text: hint)
        when Hash then HINT_DEFAULTS.merge(hint)
        when TrueClass then __hint_hash(attribute)
        else hint
        end
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

      def __with_optional(label_text, optional)
        return label_text if label_text.nil? || !optional

        "#{label_text} #{@template.t(OPTIONAL_I18N_KEY)}"
      end
    end
  end
end
