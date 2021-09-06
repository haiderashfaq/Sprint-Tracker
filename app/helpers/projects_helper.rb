module ProjectsHelper
  def project_start_date_label
    if !@project.start_date.nil? && @project.start_date < Date.today
      t('shared.started_on')
    else
      t('shared.starting_on')
    end
  end

  def project_end_date_label
    if !@project.end_date.nil? && @project.end_date < Date.today
      t('shared.ended_on')
    else
      t('shared.due_on')
    end
  end
end
