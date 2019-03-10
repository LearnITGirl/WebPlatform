module MenteeProfileHelper

  def url_with_protocol(url)
    /^http|https/i.match(url) ? url : "https://#{url}"
  end

  def display_timezone(time_zone)
    return unless time_zone
    "GMT #{time_zone.match(/[+-]*\d/)[0]}"
  end
end
