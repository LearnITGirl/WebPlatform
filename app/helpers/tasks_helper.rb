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
end
