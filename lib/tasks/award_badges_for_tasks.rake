namespace :award_badges_for_tasks do
  
  desc "award ambitious badge"
  task ambitious_badge: :environment do
  	@projects = Project.all
  	@projects.each do |project|
  	   @week = get_current_week(Date.today -1.day)
  	   if (@week.number >= 3 && is_task_of_current_week_completed(@week.number, project) && is_task_of_current_week_completed(@week.number - 1, project) && is_task_of_current_week_completed(@week.number - 2, project) ) 
  	   	 assign_amibitious_badge
  	   end
  	   #week.number < {lastweekofEdition} &&
  	   print @week.number
  	   if (is_task_of_current_week_completed(@week.number, project) && is_task_of_current_week_completed(@week.number + 1, project))
  	   	 assign_energetic_badge
  	   elsif (is_task_of_current_week_completed(@week.number, project))
  	   	assign_timekeeper_badge
       end
     end
  end


  private

  def is_task_of_current_week_completed(week, project)
    print week
    print project.title
    if (((project.tasks).all_tasks_ofthat_week(week).count >= 1) && (project.tasks.unfinished_tasks_ofthat_week(week, project.mentee) == 0))
       return true
    elsif false
    end
  end

  def get_current_week(date)
  	Week.where("edition_id = :edition_id and (start <= :curr_date and 'end' >= :curr_date)", {curr_date: date, edition_id: Edition.last}).first
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

