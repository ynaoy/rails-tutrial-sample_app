require 'test_helper'

class UsersApiTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    log_in_as(@user)
  end

  test "should get index json format" do
    get users_path, as: :json
    assert_response 200
  end

  test "should get show json format" do
    get user_path(@user), as: :json
    assert_response 200
    assert_equal 2, JSON.parse(response.body).count
  end

  test "should get create json format" do
    # 無効なパラメータ
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: " ",
                                         email: " " } }, as: :json
    end
    assert_response 400

    # 有効なパラメータ
    assert_difference 'User.count', 1 do
     post users_path, params: { user: { name: 'New_User',
                                        email: 'new_user@example.com',
                                        password: 'password',
                                        password_confirmation: 'password' } }, as: :json
    end
    assert_response 200
  end

  test "should get update json format" do
    # 無効なパラメータ
    #get edit_user_path(@user)
    patch user_path(@user), params: { user: { name: '',
                                               email: '' } }, as: :json
    assert_response 400

    # 有効なパラメータ
    #get edit_user_path(@user)
    patch user_path(@user),params: { user: { name: 'Updated_User',
                                              email: 'updated@example.com' } }, as: :json
    assert_response 200
  end

  test "should get following json format" do
    get following_user_path(@user), as: :json
    assert_response 200
  end

  test "should get followers json format" do
    get followers_user_path(@user), as: :json
    assert_response 200
  end

end
