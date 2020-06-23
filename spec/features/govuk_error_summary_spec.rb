require 'rails_helper'
RSpec.describe 'govuk_fieldset', type: :feature, js: true do
  include_context 'components test page'
  it 'exists' do
    test_page.load
    test_page.with_errors
    expect(test_page).to have_govuk_error_summary
  end

  it 'has correct errors' do
    aggregate_failures 'validating content' do
      test_page.load
      test_page.with_errors
      expect(test_page).to have_text('Test error summary')
      expect(test_page).to have_text('Text field error')
      expect(test_page).to have_text('Text area error')
      expect(test_page).to have_text('Date field error')
      expect(test_page).to have_text('Collection radio buttons error')
      expect(test_page).to have_text('Phone field error')
      expect(test_page).to have_text('Email field error')
      expect(test_page).to have_text('Collection check boxes error')
      expect(test_page).to have_text('File field error')
    end
  end
end
