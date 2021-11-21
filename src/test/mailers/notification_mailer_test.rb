require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "follow_notice" do
    from_user = users(:michael)
    to_user =   users(:mhartl)
    mail = NotificationMailer.follow_notice(from_user,to_user)
    assert_equal "Follow notification",      mail.subject
    assert_equal [to_user.email],            mail.to
    assert_equal ["noreply@example.com"],    mail.from
    assert_match to_user.name,               mail.body.encoded
    assert_match from_user.name,             mail.body.encoded
  end

end
