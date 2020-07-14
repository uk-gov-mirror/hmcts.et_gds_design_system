require "govuk_design_system_formbuilder"
module EtGdsDesignSystem
  module Form
    class Builder < ::GOVUKDesignSystemFormBuilder::FormBuilder

      def govuk_date_field(*args, label:, **kw_args)
        super(*args, legend: label, **kw_args)
      end

      def govuk_collection_radio_buttons(*args, label:, **kw_args)
        super(*args, legend: label, **kw_args)
      end

      def govuk_collection_check_boxes(*args, label:, **kw_args)
        super(*args, legend: label, **kw_args)
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
    end
  end
end
