class OrganisersMailer < ApplicationMailer
   
    def organisers_add_email(user)
      @user = user
      @url = edit_organiser_url(SecureRandom.hex(8))
      mail(:to => user, :subject=> "Invitation to LIT as a organiser")
    end
end
