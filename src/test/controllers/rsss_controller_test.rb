require 'test_helper'

class RsssControllerTest < ActionDispatch::IntegrationTest

  test "index should require logged-in user" do
    get rss_path(users(:michael))
    assert_redirected_to login_url
  end
end
