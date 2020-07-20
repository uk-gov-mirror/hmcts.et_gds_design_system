require 'rails_helper'
RSpec.describe 'govuk_file_field', type: :feature, js: true do
  include_context 'components test page'
  it 'exists' do
    test_page.load
    expect(test_page).to have_govuk_file_field
  end

  it 'has the correct label' do
    test_page.load
    expect(test_page.govuk_file_field.label.text).to eql 'File field label'
  end

  it 'has no hint by default' do
    test_page.load
    expect(test_page.govuk_file_field).not_to have_hint
  end

  it 'has the correct hint when added' do
    test_page.load
    test_page.with_hints
    expect(test_page.govuk_file_field.hint.text).to eql 'File field hint'
  end

  it 'has no errors by default' do
    test_page.load
    expect(test_page.govuk_file_field).not_to have_error
  end

  it 'has errors when added' do
    test_page.load
    test_page.with_errors
    test_page.govuk_file_field.assert_error_message("File field error")
  end
end
