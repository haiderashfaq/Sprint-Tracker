module SprintsHelper

  STATUS_COLOR = { PLANNING: 'primary', ACTIVE: 'danger', CLOSED: 'success' }.freeze

  def project_options_to_add_sprint(projects)
    projects.map { |project| [project.name, project.id] }
  end

  def complete_sprint_drop_down_options(project)
    project.sprints.where(status: PLANNING).map { |sprint| [sprint.name, sprint.id] }
  end

  def sprint_options_to_add_issues(sprints)
    sprints.map { |sprint| [sprint.name, sprint.sequence_num] }
  end

end
