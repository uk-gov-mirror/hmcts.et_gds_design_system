require 'rails_helper'
RSpec.describe 'govuk_submit', type: :feature, js: true do
  include_context 'components test page'
  it 'exists' do
    test_page.load
    expect(test_page).to have_govuk_submit
  end
end
