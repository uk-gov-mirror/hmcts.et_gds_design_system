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
end
