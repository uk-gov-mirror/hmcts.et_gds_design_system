require 'rails_helper'
RSpec.describe 'govuk_collection_select', type: :feature, js: true do
  include_context 'components test page'
  it 'exists' do
    test_page.load
    expect(test_page).to have_govuk_collection_select
  end

  it 'has the correct label' do
    test_page.load
    expect(test_page.govuk_collection_select.label.text).to eql 'Collection select label'
  end

  it 'has no hint by default' do
    test_page.load
    expect(test_page.govuk_collection_select).not_to have_hint
  end

  it 'has the correct hint when added' do
    test_page.load
    test_page.with_hints
    expect(test_page.govuk_collection_select.hint.text).to eql 'Collection select hint'
  end

  it 'has no errors by default' do
    test_page.load
    expect(test_page.govuk_collection_select).not_to have_error
  end

  it 'has errors when added' do
    test_page.load
    test_page.with_errors
    expect(test_page.govuk_collection_select.error.text).to eql "Collection select error"
  end

  it 'can be set and value returned' do
    test_page.load
    test_page.govuk_collection_select.set('Email')
    expect(test_page.govuk_collection_select.value).to eql 'Email'
  end
end
