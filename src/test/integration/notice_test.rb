require 'test_helper'

class NoticeTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
    @other = users(:archer)
    log_in_as(@user)
  end

  test "delivered mail when follow_noticed" do
    post relationships_path, xhr: true, params: { followed_id: @other.id }
    assert_equal 1, ActionMailer::Base.deliveries.size
  end

  test "delivered mail when not_follow_noticed" do
    log_in_as(@other)
    @other.not_notice_follow
    log_in_as(@user)
    post relationships_path, xhr: true, params: { followed_id: @other.id }
    assert_equal 0, ActionMailer::Base.deliveries.size
  end

  test "notice when followed" do
    delete notice_follow_path, xhr: true, params: { id: @user.id }
    assert_match "notice when followed", response.body
    patch notice_follow_path, xhr: true, params: { id: @user.id }
    assert_match "not notice when followed", response.body
  end

end
