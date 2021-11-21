require 'test_helper'

class ReplayTest < ActiveSupport::TestCase

  def setup
    @replay = Replay.new(replay_to: users(:mhartl).name,
                         replay_from: users(:michael).name,
                         micropost_id: microposts(:michael_to_mhartl).id)
  end

  test "should be valid" do
    assert @replay.valid?
  end

  test "should require a replay_to" do
    @replay.replay_to = nil
    assert_not @replay.valid?
  end

  test "should require a replay_from" do
    @replay.replay_from = nil
    assert_not @replay.valid?
  end

  test "should require a micropost_id" do
    @replay.micropost_id = nil
    assert_not @replay.valid?
  end

end
