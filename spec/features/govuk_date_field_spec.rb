require 'rails_helper'
RSpec.describe 'govuk_date_field', type: :feature, js: true do
  include_context 'components test page'
  it 'exists' do
    test_page.load
    expect(test_page).to have_govuk_date_field
  end

  it 'has the correct label' do
    test_page.load
    expect(test_page.govuk_date_field.label.text).to eql 'Date field label'
  end

  it 'has no hint by default' do
    test_page.load
    expect(test_page.govuk_date_field).not_to have_hint
  end

  it 'has the correct hint when added' do
    test_page.load
    test_page.with_hints
    expect(test_page.govuk_date_field.hint.text).to eql 'Date field hint'
  end

  it 'has no errors by default' do
    test_page.load
    expect(test_page.govuk_date_field).not_to have_error
  end

  it 'has errors when added' do
    test_page.load
    test_page.with_errors
    expect(test_page.govuk_date_field.error.text).to eql "Date field error"
  end
end
