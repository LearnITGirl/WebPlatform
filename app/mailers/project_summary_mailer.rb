class ProjectSummaryMailer < ApplicationMailer

  def project_summary(user)
    @user = user
    @newtask = @user.newtask
    mail(to: user.email, subject: "[Learn IT, Girl] Daily summary of your board")
  end
end
