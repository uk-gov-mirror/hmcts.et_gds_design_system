require 'rails_helper'
RSpec.describe 'govuk_email_field', type: :feature, js: true do
  include_context 'components test page'
  it 'exists' do
    test_page.load
    expect(test_page).to have_govuk_email_field
  end

  it 'has the correct label' do
    test_page.load
    expect(test_page.govuk_email_field.label.text).to eql 'Email field label'
  end

  it 'has no hint by default' do
    test_page.load
    expect(test_page.govuk_email_field).not_to have_hint
  end

  it 'has the correct hint when added' do
    test_page.load
    test_page.with_hints
    expect(test_page.govuk_email_field.hint.text).to eql 'Email field hint'
  end

  it 'has no errors by default' do
    test_page.load
    expect(test_page.govuk_email_field).not_to have_error
  end

  it 'has errors when added' do
    test_page.load
    test_page.with_errors
    expect(test_page.govuk_email_field.error.text).to eql "Email field error"
  end
end
