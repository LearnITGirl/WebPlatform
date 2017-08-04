class MenteeApplicationMailer < ApplicationMailer
  add_template_helper(MentorApplicationsHelper)

  def confirm_application(application)
    @application = application
    mail(to: application.email, subject: "Learn IT Girl - Thank you for your application")
  end
end
