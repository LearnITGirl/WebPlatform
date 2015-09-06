class MentorApplicationMailer < ApplicationMailer

  def confirm_application(mentor)
    @mentor = mentor
    mail(to: @mentor.email, subject: "Thank you for your application")
  end
end
