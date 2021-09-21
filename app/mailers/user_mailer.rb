class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.alert.subject
  #

  default from: "flash@info.com"

  def alert(user, issue, changes, subdomain)
    binding.pry

    @greeting = "Hi " + user.name
    @issue = issue
    @subdomain = subdomain
    @changes = issue

    mail to: user.email, subject: "Issue Notification"
  end
end
