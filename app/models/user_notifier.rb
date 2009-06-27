class UserNotifier < ActionMailer::Base
  def token user
    subject WEBSITE + ': how to change your password'
    recipients user.email
    from EMAIL
    sent_on Time.now
    body :id => user.id, :name => user.name,
      :token => user.forgot_password_token
  end
end