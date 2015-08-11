module MentorsHelper

  def timezone_options
    ActiveSupport::TimeZone.all.sort.map do |zone|
      [zone.to_s, "#{timezone_to_offset_string(zone)} - #{zone.name}"]
    end
  end

  def timezone_to_offset_string(timezone)
    timezone.now.utc_offset / 3600
  end
end
