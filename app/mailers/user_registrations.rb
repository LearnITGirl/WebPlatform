class UserRegistrations < ApplicationMailer

  def user_registration_reminder(user)
  	@user = User.find user.id
  	 @url =  edit_user_registration_url(@user.registration_token)
  	 mail(:to => user.email,
       :subject => "[Learn IT, Girl] Warning. Registration not complete. Action required")
  end

end
