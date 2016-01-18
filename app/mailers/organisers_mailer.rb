class OrganisersMailer < ApplicationMailer

    def register(user)
      @user = user
      @url = edit_organiser_registration_url(@user.organiser_token)
      mail(to: user.email, subject: "Invitation to LITG as an organiser")
    end
end
