module ReportsHelper

  def calculate_progress(estimated_time, time_spent)
    value = 0
    value = [estimated_time, time_spent].min / [estimated_time, time_spent].max unless estimated_time.zero? && time_spent.zero
    value = value.to_f * 100
  end

  def assignee_link(sprint_report)
    if sprint_report.assignee.nil?
      sprint_report.assignee_name
    else
      link_to sprint_report.assignee_name, user_path(sprint_report.assignee.sequence_num)
    end
  end

  def sprint_filter
    if request&.referer&.split('/')&.include?("sprint")
      'sprint_report'
    else
      'issue_report'
    end
  end

  def csv_link
    if request&.referer&.split('/')&.include?('sprint')
      sprint_report_path(format: :csv, sprint_id: params[:sprint_id])
    else
      issue_report_path(format: :csv, sprint_id: params[:sprint_id])
    end
  end

  def get_progress_width(value)
  	100 - value
  end
end
