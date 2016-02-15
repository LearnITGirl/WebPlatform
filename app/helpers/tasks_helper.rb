module TasksHelper

  def checked_task_status
    mentee_checked_task_status
  end

  def is_disabled(task)
    task.accepted? || task.trash?
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
    !task.accepted? && task.creator != current_user && (task.finished? || task.trash?)
  end

  def require_confirmation?(task)
    !task.accepted? && task.creator == current_user && task.finished?
  end

  def confirm_removal?(task)
    task.creator == current_user && task.trash?
  end

  def week_url(week_number)
    current_user.mentee? ? dashboard_mentee_profiles_path(week: week_number) : dashboard_mentor_profiles_path(week: week_number)
  end

  def user_dashboard_path
    current_user.mentee? ? dashboard_mentee_profiles_path(week: 'all') : dashboard_mentor_profiles_path(week: 'all')
  end

  def is_creator?(task)
    current_user == task.creator
  end
end
