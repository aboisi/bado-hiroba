require "test_helper"

class Public::GroupMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_group_members_index_url
    assert_response :success
  end
end
