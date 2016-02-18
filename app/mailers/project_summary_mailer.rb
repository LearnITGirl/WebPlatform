class ProjectSummaryMailer < ApplicationMailer

  def weekly_summary(user, date)
    @user = user
    @date = date
    @tasks = user.last_week_tasks(date.last_week)
    mail(to: user.email, subject: "[Learn IT, Girl] Daily summary of your board")
  end
end
