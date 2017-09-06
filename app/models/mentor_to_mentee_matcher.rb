class MentorToMenteeMatcher

  def run
    matcher_algorithm(with_time_zone: true)
    matcher_algorithm(with_time_zone: false)

    p ApplicationMatch.all.size
  end

  private

  def matcher_algorithm(with_time_zone: true)
    mentors.each do |mentor|
      languages = count_languages
      languages.each do |language|
        if mentor.programming_languages.pluck(:slug).include?(language[:slug])
          break unless mentees(language, mentor.country).each do |mentee|
            if !with_time_zone || (timezone_difference(mentor.time_zone, mentee.time_zone) <= 2)
              ApplicationMatch.create!(mentor_application_id: mentor.id, mentee_application_id: mentee.id)
              break
            end
          end
        end
      end
    end
  end

  def count_languages
    ProgrammingLanguage.joins(:mentor_applications)
           .where(mentor_applications: {id: mentors.pluck(:id)})
           .pluck(:slug)
           .flatten
           .group_by {|x| x }
           .map {|x, match| {slug: x, number: match.count} }
           .sort_by { |x| x[:number] }
  end

  def mentors
    MentorApplication.evaluated.where("evaluations.score >= ?", 40)
        .where.not(id: ApplicationMatch.pluck(:mentor_application_id))
        .order("evaluations.score DESC")
  end

  def mentees(language, country)
    mentees = MenteeApplication.evaluated.where("evaluations.score >= ?", 10)
                               .joins(:programming_language)
                               .where(programming_languages: {slug: language[:slug].downcase})
                               .order("evaluations.score DESC")
                               .where.not(id: ApplicationMatch.pluck(:mentee_application_id))

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
