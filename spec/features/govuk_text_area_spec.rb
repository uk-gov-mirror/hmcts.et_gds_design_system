require 'rails_helper'
RSpec.describe 'govuk_area_field', type: :feature, js: true do
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
    expect(test_page.govuk_text_area.error.text).to eql "Text area error"
  end
end
