require 'test_helper'

class PriceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get price_index_url
    assert_response :success
  end

end
