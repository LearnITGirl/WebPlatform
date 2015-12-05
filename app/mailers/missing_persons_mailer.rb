class MissingPersonsMailer < ApplicationMailer

  def MissingMentor(user)
      @user = user
      @url = mentee_profile_url(@user.id)
      mail(:to => "learnitgirl.office@gmail.com", :subject=> "LITG platform - reporting missing mentor")
  end
   
end
