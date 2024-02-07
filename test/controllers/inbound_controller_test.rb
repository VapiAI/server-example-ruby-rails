require "test_helper"

class InboundControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get inbound_create_url
    assert_response :success
  end
end
