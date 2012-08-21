class UserNotifier < ActionMailer::Base
  def token(user)
    @id = user.id
    @name = user.name
    @token = user.forgot_password_token

    mail(to: user.email, from: EMAIL, subject: WEBSITE + ': how to change your password')
  end
end