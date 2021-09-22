class Dashboard

  def self.issues_estimated_time(project)
    total_time = 0
    if project.issues.any?
      total_time = project.total_spent_time
    end
  end

  def self.issues_logged_time(project)
    total_time = 0
    if project.issues.any?
      total_time = project.total_logged_time
    end
  end

  def self.fetch_project_issues(project)
    if project.active_sprint.present?
      project.active_sprint.issues
    end
  end

  def self.fetch_projects
    Company.current_company.projects
  end

  def self.fetch_sprints
    Sprint.all
  end

  def self.fetch_issues
    Company.current_company.issues
  end

  def self.fetch_sprint_issues(project)
    if project.active_sprint.present?
      project.active_sprint.issues
    end
  end

end
