class ProjectSummaryMailer < ApplicationMailer

  def project_summary(user, date)
    @user = user
    @date = date
    mail(to: user.email, subject: "[Learn IT, Girl] Daily summary of your board - #{DateTime.now.strftime("%d %b %Y")}")
  end
end
