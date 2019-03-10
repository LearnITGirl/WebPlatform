module ProjectsHelper

  def setup_project(project)
    unless project.roadmap_entries.any?
      current_edition.weeks.order(:number).each do |w|
        project.roadmap_entries.build(week_id: w.id, edition_id: current_edition.id)
      end
    end
    project
  end
end
