class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.alert.subject
  #

  default from: FLASH_INFO_EMAIL

  def issue_alert(user, issue, subdomain, current_user, subject)
    @name = user.name
    @issue = issue
    @subdomain = subdomain
    @current_user = current_user

    mail to: user.email, subject: subject
  end
end
