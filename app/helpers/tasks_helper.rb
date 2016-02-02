module TasksHelper

  def checked_task_status
    current_user.mentee? ? mentee_checked_task_status : mentor_checked_task_status
  end

  def unchecked_task_status
    "not_done"
  end

  def mentee_checked_task_status
    "finished"
  end

  def mentor_checked_task_status
    "accepted"
  end

  def checked(task)
    task.finished? || task.accepted?
  end

  def awaits_confirmation?(task)
    current_user.mentee? && !task.accepted? && task.creator != current_user && task.finished?
  end

  def require_confirmation?(task)
    current_user.mentor? && !task.accepted? && task.creator == current_user && task.finished?
  end

  def week_url(week_number)
    current_user.mentee? ? dashboard_mentee_profiles_path(week: week_number) : dashboard_mentor_profiles_path(week: week_number)
  end

  def user_dashboard_path
    current_user.mentee? ? dashboard_mentee_profiles_path(week: 'all') : dashboard_mentor_profiles_path(week: 'all')
  end
end
