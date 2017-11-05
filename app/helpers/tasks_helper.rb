module TasksHelper

  def checked_task_status
    mentee_checked_task_status
  end

  def is_disabled(task)
    return true if current_user.organizer?
    task.accepted? || task.trash? || past_week?
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
    return false if current_user.organizer?
    current_user == task.creator
  end

  def creator_label(task)
    if task.creator.mentor?
      "Project task"
    elsif task.creator.mentee? && current_user.mentee?
      "My TODO"
    else
      "Created by mentee"
    end
  end

  def past_week?
    @week && @week.end.past?
  end


  def disable_finished_task?(task)
    !is_creator?(task) || past_week?
  end
end
