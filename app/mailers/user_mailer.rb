class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.alert.subject
  #

  default from: "flash@info.com"

  def alert(user, issue, subdomain, current_user)

    @greeting = "Hi " + user.name
    @issue = issue
    @subdomain = subdomain
    @current_user = current_user

    mail to: user.email, subject: "Issue Notification"
  end
end
