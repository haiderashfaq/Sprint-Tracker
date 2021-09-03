module ProjectsHelper
  def project_start_date_label
    if !@project.start_date.nil? && @project.start_date < Date.today
      t('projects.started_on')
    else
      t('projects.starting_on')
    end
  end

  def project_end_date_label
    if !@project.start_date.nil? && @project.end_date < Date.today
      t('projects.ended_on')
    else
      t('projects.due_on')
    end
  end
end
