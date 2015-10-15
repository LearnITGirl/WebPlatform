class UserMailer < ApplicationMailer

  def reset_password_email(user)
    @greeting = "Hi"

    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(:to => user.email,
       :subject => "Your password has been reset")
  end

end
