class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.alert.subject
  #

  default from: EMAIL

  def alert(user, issue, subdomain, current_user, subject)
    @greeting = "Hi " + user.name
    @issue = issue
    @subdomain = subdomain
    @current_user = current_user

    mail to: user.email, subject: subject
  end
end
