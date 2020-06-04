require 'rails_helper'
RSpec.describe 'govuk_fieldset', type: :feature, js: true do
  include_context 'components test page'
  it 'exists' do
    test_page.load
    expect(test_page).to have_govuk_fieldset
  end

  it 'has the correct label' do
    test_page.load
    expect(test_page.govuk_fieldset.label.text).to eql 'Fieldset label'
  end
end
