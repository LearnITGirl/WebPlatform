module ApplicationHelper

  def glyphicon *names
    content_tag :span, nil, class: names.map{|name| "glyphicon-#{name.to_s.gsub('_','-')}" } + ["glyphicon"]
  end

  def main_path
    case current_user.try(:role)
    when "organizer" then dashboard_organisers_path
    when "mentor" then dashboard_mentor_profiles_path
    when "mentee" then dashboard_mentee_profiles_path
    else
      root_path
    end
  end

  def edit_profile
    case current_user.try(:role)
    when "mentor" then edit_mentor_profile_path(current_user)
    when "mentee" then edit_mentee_profile_path(current_user)
    when "organizer" then edit_organiser_path(current_user)
    end
  end

  def edition_started?
    current_edition.start_date <= DateTime.now
  end

  def menu_links
    links = []
    if current_user && current_user.organizer?
      links << (content_tag :li, link_to('Manage organizers', organisers_path), class: "no-image")
      links << (content_tag :li, link_to('Email templates', email_templates_path), class: "no-image")
      links << (content_tag :li, link_to('Matched pairs', mentor_to_mentee_matchers_path), class: "no-image")
      links << (content_tag :li, link_to('Skipped Applications', skipped_applications_path), class: "no-image")
    end
    if current_user && current_user.mentee?
      links << (content_tag :li, link_to('Mentee do\'s and don\'ts', mentee_dos_and_donts_path), class: "no-image")
    end
    if current_user && current_user.mentor?
      links << (content_tag :li, link_to('Mentor do\'s and don\'ts', mentor_dos_and_donts_path), class: "no-image")
    end
    links << (content_tag :li, link_to('Timeline', timeline_path), class: "no-image")
    links << (content_tag :li, link_to('Sponsors', sponsors_path), class: "no-image")
    links << (content_tag :li, link_to('FAQs', faq_path), class: "no-image")
    links << (content_tag :li, link_to('About us', about_us_path), class: "no-image")
  end
end
