module ReportsHelper

  def calculate_progress(estimated_time, time_spent)
    value = 0
    value = [estimated_time, time_spent].min / [estimated_time, time_spent].max if !estimated_time.zero? && !time_spent.zero?
    value = value.to_f * 100
  end

  def assignee_link(sprint_report)
    if sprint_report.assignee.nil?
      I18n.t 'issues.no_assignee'
    else
      link_to sprint_report.assignee_name, user_path(sprint_report.assignee)
    end
  end

  def get_sprint_path
    sprint_reports_path(format: :csv, sprint_id: params[:sprint_id])
  end

  def get_issue_path
    issues_reports_path(format: :csv, sprint_id: params[:sprint_id])
  end

  def get_progress_width(value)
    100 - value
  end
end
