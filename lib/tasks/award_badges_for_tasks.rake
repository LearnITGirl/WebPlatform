namespace :award_badges_for_tasks do
  desc "award ambitious badge"
  task ambitious_badge: :environment do
  	@projects = Project.all
  	@projects.each do |project|
  	   #@week = (Date.now -1.day)
  	   if (week.number >= 3 && is_task_of_current_week_completed(week.number) && is_task_of_current_week_completed(week.number - 1) && is_task_of_current_week_completed(week.number - 2) ) 
  	   	 assign_amibitious_badge
  	   elsif (week.number < {lastweekofEdition} && is_task_of_current_week_completed(week.number) && is_task_of_current_week_completed(week.number + 1))
  	   	 assign_energetic_badge
  	   elsif (is_task_of_current_week_completed(week.number))
  	   	assign_timekeeper_badge
       end
  end

  private

  def is_task_of_current_week_completed(week, project)
    
    if ((project.tasks.all_tasks_ofthat_week(week.number).count >= 1) && if (@project.tasks.unfinished_tasks_ofthat_week(week, project.mentee) == 0))
        return true
    else false
    end

  end

  def assign_amibitious_badge
		@project.mentee.badges << Badge.ambitious
  end

  def assign_energetic_badge
		@project.mentee.badges << Badge.energetic
  end

  def assign_timekeeper_badge
       @project.mentee.badges << Badge.timekeeper
  end

end

