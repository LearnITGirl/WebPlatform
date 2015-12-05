class MissingPersonsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.missing_persons_mailer.MissingMentor.subject
  #
  def MissingMentor(user)
      @user = user
      @url = mentee_profile_url(@user.id)
      mail(:to => "learnitgirl.office@gmail.com", :subject=> "LITG platform - reporting missing mentor")
  end
   
end
