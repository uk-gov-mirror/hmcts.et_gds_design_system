require 'rails_helper'
RSpec.describe 'govuk_text_field', type: :feature, js: true do
  include_context 'components test page'
  it 'exists' do
    test_page.load
    expect(test_page).to have_govuk_text_field
  end

  it 'has the correct label' do
    test_page.load
    expect(test_page.govuk_text_field.label.text).to eql 'Text field label'
  end

  it 'has no hint by default' do
    test_page.load
    expect(test_page.govuk_text_field).not_to have_hint
  end

  it 'has the correct hint when added' do
    test_page.load
    test_page.with_hints
    expect(test_page.govuk_text_field.hint.text).to eql 'Text field hint'
  end

  it 'has no errors by default' do
    test_page.load
    expect(test_page.govuk_text_field).not_to have_error
  end

  it 'has errors when added' do
    test_page.load
    test_page.with_errors
    test_page.govuk_text_field.assert_error_message("Text field error")
  end

  it 'can be set and value returned' do
    test_page.load
    test_page.govuk_text_field.set('Test value')
    expect(test_page.govuk_text_field.value).to eql 'Test value'
  end
end
