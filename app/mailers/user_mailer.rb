class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Activation du compte"
  end
  def password_reset(user)
	@user = user
		mail to: user.email, subject: "Mot de passe"
	end
end