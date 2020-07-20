require 'rails_helper'
RSpec.describe 'govuk_collection_check_boxes', type: :feature, js: true do
  include_context 'components test page'
  it 'exists' do
    test_page.load
    expect(test_page).to have_govuk_collection_check_boxes
  end

  it 'has the correct label' do
    test_page.load
    expect(test_page.govuk_collection_check_boxes.label.text).to eql 'Collection check boxes label'
  end

  it 'has no hint by default' do
    test_page.load
    expect(test_page.govuk_collection_check_boxes).not_to have_hint
  end

  it 'has the correct hint when added' do
    test_page.load
    test_page.with_hints
    expect(test_page.govuk_collection_check_boxes.hint.text).to eql 'Collection check boxes hint'
  end

  it 'has no errors by default' do
    test_page.load
    expect(test_page.govuk_collection_check_boxes).not_to have_error
  end

  it 'has errors when added' do
    test_page.load
    test_page.with_errors
    test_page.govuk_collection_check_boxes.assert_error_message("Collection check boxes error")
  end

  it 'can be set and value returned' do
    test_page.load
    test_page.govuk_collection_check_boxes.set(['Post', 'Email'])
    expect(test_page.govuk_collection_check_boxes.value).to eql ['Post', 'Email']
  end
end
