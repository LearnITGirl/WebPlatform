class OrganisersMailer < ApplicationMailer
   
    def organisers_add_email(user)
      @user = user
      @url = edit_organisers_url(SecureRandom.hex(8))
      mail(:to => user.email, :subject=> "Invitation to LIT as a organiser")

end
