require 'rails_helper'
RSpec.describe 'govuk_fieldset', type: :feature, js: true do
  include_context 'components test page'
  it 'exists' do
    test_page.load
    test_page.with_errors
    expect(test_page).to have_govuk_error_summary
  end
end
