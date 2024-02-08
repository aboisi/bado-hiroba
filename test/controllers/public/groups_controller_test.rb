require "test_helper"

class Public::GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_groups_show_url
    assert_response :success
  end
end
