class MenteesMailer < ApplicationMailer
	def register(user)
		@user = user
		@url = edit_user_registration_url(@user.registration_token)
		mail(to: user.email, 
			subject: "[Learn IT, Girl] Congratulations! Welcome as a second edition mentee.")
	end
end
