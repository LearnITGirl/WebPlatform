class MentorToMenteeMatcher

  def run
    match_algorithm(with_time_zone: true)
    match_algorithm(with_time_zone: false)

    p ApplicationMatch.all.size
  end

  def rematch
    rematch_for_waiting_mentors_and_mentees(with_time_zone: true)
    rematch_for_waiting_mentors_and_mentees(with_time_zone: false)

    rematch_for_waiting_mentors(with_time_zone: true)
    rematch_for_waiting_mentors(with_time_zone: false)

    rematch_for_waiting_mentees(with_time_zone: true)
    rematch_for_waiting_mentees(with_time_zone: false)

    match(with_time_zone: true)
    match(with_time_zone: false)
  end

  private

  def match(with_time_zone: true)
    run_algorithm(:all_mentors, :all_ordered_mentees, with_time_zone)
  end

  def rematch_for_waiting_mentors_and_mentees(with_time_zone: true)
    run_algorithm(:mentors_waiting_for_rematch, :mentees_waiting_for_rematch, with_time_zone)
  end

  def rematch_for_waiting_mentors(with_time_zone: true)
    run_algorithm(:mentors_waiting_for_rematch, :all_ordered_mentees, with_time_zone)
  end

  def rematch_for_waiting_mentees(with_time_zone: true)
    run_algorithm(:all_mentors, :mentees_waiting_for_rematch, with_time_zone)
  end

  def run_algorithm(mentors, mentees, with_time_zone)
    send(mentors).each do |mentor|
      languages = count_languages(mentors)
      languages.each do |language|
        if mentor.programming_languages.pluck(:slug).include?(language[:slug])
          break unless send(mentees,language, mentor.country).each do |mentee|
            if !with_time_zone || (timezone_difference(mentor.time_zone, mentee.time_zone) <= 2)
              ApplicationMatch.create!(mentor_application_id: mentor.id, mentee_application_id: mentee.id)
              break
            end
          end
        end
      end
    end
  end

  def count_languages(mentors)
    ProgrammingLanguage.joins(:mentor_applications)
           .where(mentor_applications: {id: send(mentors).pluck(:id)})
           .pluck(:slug)
           .flatten
           .group_by {|x| x }
           .map {|x, match| {slug: x, number: match.count} }
           .sort_by { |x| x[:number] }
  end

  def all_mentors
    MentorApplication.evaluated.where("evaluations.score >= ?", 40)
      .where.not(id: ApplicationMatch.pluck(:mentor_application_id))
      .order("evaluations.score DESC")
      .where.not(state: MentorApplication.states[:user_resigned])
  end

  def mentors_waiting_for_rematch
    all_mentors.waiting_for_rematch
  end

  def all_mentees(language, country)
    MenteeApplication.evaluated.where("evaluations.score >= ?", 10)
      .joins(:programming_language)
      .where(programming_languages: {slug: language[:slug].downcase})
      .order("evaluations.score DESC")
      .where.not(id: ApplicationMatch.pluck(:mentee_application_id))
      .where.not(state: MenteeApplication.states[:user_resigned])
  end

  def all_ordered_mentees(language, country)
    mentees = all_mentees(language, country)
    mentees.where.not(country: country) + mentees.where(country: country) 
  end

  def mentees_waiting_for_rematch(language, country)
    mentees = all_mentees(language, country).waiting_for_rematch
    mentees.where.not(country: country) + mentees.where(country: country) 
  end

  def timezone_difference(timezone1, timezone2)
    Time.zone = timezone1.gsub(/.*\s-\s/, '')
    t1 = Time.zone.now

    Time.zone = timezone2.gsub(/.*\s-\s/, '')
    t2 = Time.zone.now

    (t2.hour - t1.hour).abs
  end
end
