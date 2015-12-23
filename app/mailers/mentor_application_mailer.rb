class MentorApplicationMailer < ApplicationMailer

  def confirm_application(mentor)
    @mentor = mentor
    mail(to: @mentor.email, subject: "Learn IT Girl - Thank you for your application")
  end
end
