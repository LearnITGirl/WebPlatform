module ApplicationHelper
  def glyphicon *names
    content_tag :span, nil, class: names.map{|name| "glyphicon-#{name.to_s.gsub('_','-')}" } + ["glyphicon"]
  end
end