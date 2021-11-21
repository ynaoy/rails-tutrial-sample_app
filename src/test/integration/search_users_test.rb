require 'test_helper'

class SearchUsersTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:user_19)
  end

  test "should search correct users" do
    log_in_as(@user)
    get users_path
    assert_select 'form.form-inline'
    assert_match user_path(@other_user), response.body
    post search_users_path, xhr:true, params: { search: "archer" }
    assert_template 'search_users/index'
    first_page_of_users = User.search_user(attribute = "name",str = "archer").paginate(page: 1)
    first_page_of_users.each do |user|
      assert_match user_path(user), response.body
    end
    assert_no_match user_path(@other_user), response.body
  end

  test "should pagenation worked" do
    log_in_as(@user)
    post search_users_path, xhr:true, params: { search: "e", page: 2 }
    second_page_of_users = User.search_user(attribute = "name",str = "e").paginate(page: 2)
    second_page_of_users.each do |user|
      assert_match user_path(user), response.body
    end
    #assert_no_match user_path(users(:not_e)), response.body
  end
end
