class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Activation du compte"
  end
  def password_reset
    @greeting = "test"
    mail to: "to@example.org"
  end
end