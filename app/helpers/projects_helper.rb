module ProjectsHelper

  def setup_project(project)
    12.times { project.roadmap_entries.build } unless project.roadmap_entries.any?
    project
  end
end
