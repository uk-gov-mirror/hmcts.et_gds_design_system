require 'rails_helper'
RSpec.describe 'govuk_collection_radio_buttons', type: :feature, js: true do
  include_context 'components test page'
  it 'exists' do
    test_page.load
    expect(test_page).to have_govuk_collection_radio_buttons
  end

  it 'has the correct label' do
    test_page.load
    expect(test_page.govuk_collection_radio_buttons.label.text).to eql 'Collection radio buttons label'
  end

  it 'has no hint by default' do
    test_page.load
    expect(test_page.govuk_collection_radio_buttons).not_to have_hint
  end

  it 'has the correct hint when added' do
    test_page.load
    test_page.with_hints
    expect(test_page.govuk_collection_radio_buttons.hint.text).to eql 'Collection radio buttons hint'
  end

  it 'has no errors by default' do
    test_page.load
    expect(test_page.govuk_collection_radio_buttons).not_to have_error
  end

  it 'has errors when added' do
    test_page.load
    test_page.with_errors
    test_page.govuk_collection_radio_buttons.assert_error_message("Collection radio buttons error")
  end

  it 'can be set and value returned' do
    test_page.load
    test_page.govuk_collection_radio_buttons.set('Email')
    expect(test_page.govuk_collection_radio_buttons.value).to eql 'Email'
  end

  it 'is reloaded with value submitted' do
    test_page.load
    test_page.govuk_collection_radio_buttons.set('Email')
    test_page.submit
    test_page.assert_submitted
    test_page.govuk_collection_radio_buttons.assert_value('Email')
  end
end
