class MentorApplicationMailer < ApplicationMailer
  helper(MentorApplicationsHelper)

  def confirm_application(application)
    @application = application
    mail(to: application.email, from: 'Learn IT Girl <learnitgirl.office@gmail.com>', subject: "Learn IT Girl - Thank you for your application")
  end
end
