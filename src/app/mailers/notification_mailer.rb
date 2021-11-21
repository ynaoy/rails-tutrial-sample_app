class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.follow_notice.subject
  #
  def follow_notice(from_user, to_user)
    @from_user = from_user
    @to_user   = to_user
    mail to: to_user.email, subject: "Follow notification"
  end
end
