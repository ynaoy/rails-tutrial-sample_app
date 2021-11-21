require 'test_helper'

class RssTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    log_in_as(@user)
  end

  test "rss show" do
    get rss_path(@user)
    assert_template 'rsss/index'
    @user.feed.limit(10).each do |feed|
      assert_match feed.content, response.body
    end
  end

  test "only correct_user should use rss" do
    get rss_path(users(:archer))
    assert_redirected_to root_url
  end
end
