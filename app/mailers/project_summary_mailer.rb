class ProjectSummaryMailer < ApplicationMailer

  def project_summary(user)
    @user = user
    mail(to: user.email, subject: "[Learn IT, Girl] Daily summary of your board", sent: DateTime.now)
  end
end
