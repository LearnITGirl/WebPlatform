class MentorToMenteeMatcher
  attr_reader :mentor_evaluation_maximum_score

  def run
    @mentor_evaluation_maximum_score = 40

    match(with_time_zone: true)
    match(with_time_zone: false)

    p ApplicationMatch.all.size
  end

  def rematch
    @mentor_evaluation_maximum_score = 30

    rematch_for_waiting_mentors_and_mentees(with_time_zone: true)
    rematch_for_waiting_mentors_and_mentees(with_time_zone: false)

    rematch_for_waiting_mentors(with_time_zone: true)
    rematch_for_waiting_mentors(with_time_zone: false)

    rematch_for_waiting_mentees(with_time_zone: true)
    rematch_for_waiting_mentees(with_time_zone: false)

    @mentor_evaluation_maximum_score = 40

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
          break unless send(mentees, mentor.country).each do |mentee|
            if has_programming_language(mentee, language[:slug]) &&
              (!with_time_zone || timezone_within_range(mentor, mentee)) &&
                matches_experience(mentor, mentee, language[:slug])
              ApplicationMatch.create!(mentor_application_id: mentor.id, mentee_application_id: mentee.id)
              break
            end
          end
        end
      end
    end
  end

  def has_programming_language(mentee, language_slug)
    mentee.programming_language.slug == language_slug || mentee.other_programming_languages.include?(language_slug)
  end

  def timezone_within_range(mentor, mentee)
    (timezone_difference(mentor.time_zone, mentee.time_zone) <= 2)
  end

  def matches_experience(mentor, mentee, language_slug)
    mentee_prog_level = programming_level(mentee.programming_experience_level[language_slug])
    mentor_prog_level = programming_level(mentor.programming_experience_level[language_slug])

    # check if mentor prefers mentee's programming level and mentor has more or equal experience level than mentee.
    mentor_accepts_beginners(mentor, mentee_prog_level) && mentee_prog_level <= mentor_prog_level
  end

  def mentor_accepts_beginners(mentor, mentee_prog_level)
    (mentor.like_mentoring_beginner || (!mentor.like_mentoring_beginner && mentee_prog_level != 1))
  end

  def programming_level(programming_level)
    case programming_level
    when "professional"
      3
    when "intermediate"
      2
    else
      1
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
    MentorApplication.evaluated.where("evaluations.score >= ?", mentor_evaluation_maximum_score)
      .where.not(id: ApplicationMatch.pluck(:mentor_application_id))
      .order("evaluations.score DESC")
      .where.not(state: MentorApplication.states[:user_resigned])
  end

  def mentors_waiting_for_rematch
    all_mentors.waiting_for_rematch
  end

  def all_mentees(country)
    MenteeApplication.evaluated.where("evaluations.score >= ?", 10)
      .order("evaluations.score DESC")
      .where.not(id: ApplicationMatch.pluck(:mentee_application_id))
      .where.not(state: MenteeApplication.states[:user_resigned])
  end

  def all_ordered_mentees(country)
    mentees = all_mentees(country)
    mentees.where.not(country: country) + mentees.where(country: country)
  end

  def mentees_waiting_for_rematch(country)
    mentees = all_mentees(country).waiting_for_rematch
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
