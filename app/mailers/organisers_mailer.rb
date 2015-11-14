class OrganisersMailer < ApplicationMailer
   
    def organisers_add_email(user)
      @user = user
      @url = edit_organiser_url(@user.organiser_token)
      mail(:to => user.email, :subject=> "Invitation to LIT as a organiser")
    end
end
