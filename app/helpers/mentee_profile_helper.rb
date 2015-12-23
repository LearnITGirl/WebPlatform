module MenteeProfileHelper

  def url_with_protocol(url) 
    /^http|https/i.match(url) ? url : "https://#{url}" 
  end

end
