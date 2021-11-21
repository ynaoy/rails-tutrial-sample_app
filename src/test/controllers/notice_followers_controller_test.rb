require 'test_helper'

class NoticeFollowersControllerTest < ActionDispatch::IntegrationTest

  test "create should require logged-in user" do
    patch notice_follow_path(users(:michael))
    assert_redirected_to login_url
  end

  test "destroy should require logged-in user" do
    delete notice_follow_path(users(:michael))
    assert_redirected_to login_url
  end
end
