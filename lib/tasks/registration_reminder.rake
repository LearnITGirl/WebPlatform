namespace :registration_reminder do
  
  desc "send email reminder to unregistered mentors"
  task mentor_registration_reminder: :environment do
  	unregistered_mentors = User.where("role=? AND registration_token IS NOT NULL", User.roles[:mentor])
  	unregistered_mentors.each do |mentor|
  		UserRegistrations.user_registration_reminder(mentor).deliver
  	end
  end

  desc "send email reminder to unregistered mentees"
  task mentee_registration_reminder: :environment do
  	unregistered_mentees = User.where("role=? AND registration_token IS NOT NULL", User.roles[:mentee])
  	unregistered_mentees.each do |mentee|
  		UserRegistrations.user_registration_reminder(mentee).deliver
  	end
  end

end
