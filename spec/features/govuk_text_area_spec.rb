require 'rails_helper'
RSpec.describe 'govuk_textarea_field', type: :feature, js: true do
  include_context 'components test page'
  it 'exists' do
    test_page.load
    expect(test_page).to have_govuk_text_area
  end

  it 'has the correct label' do
    test_page.load
    expect(test_page.govuk_text_area.label.text).to eql 'Text area label'
  end

  it 'has no hint by default' do
    test_page.load
    expect(test_page.govuk_text_area).not_to have_hint
  end

  it 'has the correct hint when added' do
    test_page.load
    test_page.with_hints
    expect(test_page.govuk_text_area.hint.text).to eql 'Text area hint'
  end

  it 'has no errors by default' do
    test_page.load
    expect(test_page.govuk_text_area).not_to have_error
  end

  it 'has errors when added' do
    test_page.load
    test_page.with_errors
    test_page.govuk_text_area.assert_error_message("Text area error")
  end

  it 'can be set and value returned' do
    test_page.load
    test_page.govuk_text_area.set('Test value')
    expect(test_page.govuk_text_area.value).to eql 'Test value'
  end

  it 'is reloaded with value submitted' do
    test_page.load
    test_page.govuk_text_area.set('Test value')
    test_page.submit
    test_page.assert_submitted
    test_page.govuk_text_area.assert_value('Test value')
  end
end
