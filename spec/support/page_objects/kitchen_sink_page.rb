# A page object representing the 'Kitchen Sink' page for testing
class KitchenSinkPage < ::SitePrism::Page
  include EtTestHelpers::Page
  set_url '/kitchen_sinks/new'

  # Shows hints on all form components
  def with_hints
    click_link 'Render with hint'
  end

  # Shows errors on all form components
  def with_errors
    click_link 'Render with errors'
  end

  # Submits the form
  def submit
    govuk_submit.submit
  end

  # Validates the form has been submitted
  def assert_submitted
    submitted_element.present?
  end

  # @!method govuk_text_field
  #   A govuk text field component wrapping the input, label, hint etc..
  #   @return [EtTestHelpers::Components::TextField] The site prism section
  section :govuk_text_field, govuk_component(:text_field), :govuk_text_field, 'Text field label'

  # @!method govuk_text_area
  #   A govuk text area component wrapping the input, label, hint etc..
  #   @return [EtTestHelpers::Components::TextArea] The site prism section
  section :govuk_text_area, govuk_component(:text_area), :govuk_text_area, 'Text area label'

  # @!method govuk_date_field
  #   A govuk date field component wrapping the input, label, hint etc..
  #   @return [EtTestHelpers::Components::DateField] The site prism section
  section :govuk_date_field, govuk_component(:date_field), :govuk_date_field, 'Date field label'

  # @!method govuk_radios
  #   A govuk radio button component wrapping the input, label, hint etc..
  #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
  section :govuk_collection_radio_buttons, govuk_component(:collection_radio_buttons), :govuk_collection_radio_buttons, 'Collection radio buttons label'

  # @!method govuk_phone_field
  #   A govuk phone field component wrapping the input, label, hint etc..
  #   @return [EtTestHelpers::Components::PhoneField] The site prism section
  section :govuk_phone_field, govuk_component(:phone_field), :govuk_phone_field, 'Phone field label'

  # @!method govuk_email_field
  #   A govuk email field component wrapping the input, label, hint etc..
  #   @return [EtTestHelpers::Components::EmailField] The site prism section
  section :govuk_email_field, govuk_component(:email_field), :govuk_email_field, 'Email field label'

  # @!method govuk_check_boxes
  #   A govuk check boxes component wrapping the input, label, hint etc..
  #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
  section :govuk_collection_check_boxes, govuk_component(:collection_check_boxes), :govuk_collection_check_boxes, 'Collection check boxes label'

  # @!method govuk_collection_select
  #   A govukselect component wrapping the select, label, hint etc..
  #   @return [EtTestHelpers::Components::GovUKCollectionSelect] The site prism section
  section :govuk_collection_select, govuk_component(:collection_select), :govuk_collection_select, 'Collection select label'

  # @!method govuk_fieldset
  #   A govuk fieldset component wrapping the input, label, hint etc..
  #   @return [EtTestHelpers::Components::TextField] The site prism section
  section :govuk_fieldset, govuk_component(:fieldset), :govuk_fieldset, 'Fieldset label'

  # @!method govuk_file_field
  #   A govuk file field component wrapping the input, label, hint etc..
  #   @return [EtTestHelpers::Components::FileField] The site prism section
  section :govuk_file_field, govuk_component(:file_field), :govuk_file_field, 'File field label'

  # @!method govuk_file_dropzone_field
  #   A govuk file dropzone field component wrapping the input, label, hint etc..
  #   @return [EtTestHelpers::Components::FileDropzoneField] The site prism section
  section :govuk_file_dropzone_field, govuk_component(:file_dropzone_field), :govuk_file_dropzone_field, 'File dropzone field label'

  # @!method govuk_error_summary
  #   A govuk error summary component...
  #   @return [EtTestHelpers::Components::ErrorSummary] The site prism section
  section :govuk_error_summary, govuk_component(:error_summary), :govuk_error_summary, 'Test error summary'

  # @!method govuk_submit
  #   A govuk submit button component...
  #   @return [EtTestHelpers::Components::GovUKSubmit] The site prism section
  section :govuk_submit, govuk_component(:submit), :govuk_submit, 'Submit'

  private

  element :submitted_element, 'p', text: 'Form Submitted'
end
