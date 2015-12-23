class MenteeApplicationMailer < ApplicationMailer
  def confirm_application(mentee)
    @mentee = mentee
    mail(to: @mentee.email, subject: "Learn IT Girl - Thank you for your application")
  end
end
