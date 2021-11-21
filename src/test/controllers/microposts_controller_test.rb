require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @micropost = microposts(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong micropost" do
    log_in_as(@user)
    micropost = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      delete micropost_path(micropost)
    end
    assert_redirected_to root_url
  end

  test "should replay_count up by micropost including @" do
    log_in_as(@user)
    assert_difference 'Replay.count' do
      post microposts_path, params: { micropost: { content: "test @mhartl " }}
    end
  end

  test "should replay_count up by micropost including @*2" do
    log_in_as(@user)
    assert_difference 'Replay.count',2 do
      post microposts_path, params: { micropost: { content: "test @mhartl @micha" }}
    end
  end

  test "should replay_count down by deleted micropost including @" do
    log_in_as(@user)
    post microposts_path, params: { micropost: { content: "test @mhartl " }}
    assert_difference 'Replay.count', -1 do
      delete micropost_path(@user.microposts.reload.first)
    end
  end
end
