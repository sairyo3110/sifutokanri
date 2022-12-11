require "test_helper"

class CalControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cal_index_url
    assert_response :success
  end
end
