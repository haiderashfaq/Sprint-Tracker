class Dashboard

  def self.issues_estimated_time(project)
    total_time = 0
    project.issues.each do |issue|
      total_time += issue.estimated_time
    end
    total_time
  end

  def self.issues_logged_time(project)
    total_time = 0
    if project.active_sprint.present?
      project.active_sprint.issues.each do |issue|
        total_time += issue.total_spent_time
      end
    end
    total_time
  end

  def self.fetch_project_issues(project)
    if project.active_sprint.present?
      project.active_sprint.issues
    end
  end

  def self.fetch_projects
    Project.all
  end

  def self.fetch_sprints
    Sprint.all
  end

  def self.fetch_issues
    Issue.all
  end

  def self.fetch_sprint_issues(project)
    if project.active_sprint.present?
      project.active_sprint.issues
    end
  end

  def project_lead_fetch_sprints
    Project.all.where(manager: current_user)
  end

end
