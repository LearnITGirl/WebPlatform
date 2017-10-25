namespace :award_badge_once do
  desc "TODO"
  task award_organized_badge: :environment do
        @projects = Project.all
        @edition = Edition.last
        @projects.each do |project|
        	is_organised_flag = true
            @edition.weeks.each do |week|
                @tasks = project.tasks.where(week: week)
                if (@tasks.count < 1)
                	is_organised_flag = false
                	break
                end
			end
			if (is_organised_flag)
				assign_organised_badge(project)
			end
        end

  end

  private 
  def assign_organised_badge(project)
  	unless project.mentee.badges.timekeeper.any?
	  project.mentee.badges << Badge.organized
	end
  end

end

