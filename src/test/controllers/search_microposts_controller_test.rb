require 'test_helper'

class SearchMicropostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "should redirect index when not logged in" do
    post search_microposts_path, params: { search: "orange" }
    assert_redirected_to login_url
  end

  test "should get index" do
    log_in_as(@user)
    post search_microposts_path, params: { search: "orange" }
    assert_response :success
  end

  test "should get index javascript" do
    log_in_as(@user)
    post search_microposts_path, params: { search: "orange" }, xhr:true
    assert_response :success
  end

end
