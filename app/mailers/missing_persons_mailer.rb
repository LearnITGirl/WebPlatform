class MissingPersonsMailer < ApplicationMailer

  def missing_mentor(user)
      @user = user
      @mentorurl = mentor_profile_url(@user.partner.id)
      @menteeurl = mentee_profile_url(@user.id)
      mail(:to => "learnitgirl.office@gmail.com", :subject=> "LITG platform - reporting missing mentor")
  end

  def missing_mentee(user)
      @user = user
      @mentorurl = mentor_profile_url(@user.id)
      @menteeurl = mentee_profile_url(@user.partner.id)
      mail(:to => "learnitgirl.office@gmail.com", :subject=> "LITG platform - reporting missing mentee")
  end
end
