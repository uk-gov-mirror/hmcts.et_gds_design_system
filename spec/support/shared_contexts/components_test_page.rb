RSpec.shared_context 'components test page' do

  # @return [KitchenSinkPage] The kitchen sink page
  def test_page
    @test_page ||= KitchenSinkPage.new
  end
end
