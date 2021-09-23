class Report
  include TimeProgressions
  SPRINT_HEADERS = %w[assignee_name total_issues resolved_issues total_estimated_time total_time_spent].freeze
  ISSUE_HEADERS = %w[status title assignee_name priority category estimated_time total_time_spent].freeze

  def self.sprint_report_data(sprint)
    @sprint_report_attributes = sprint&.issues.left_outer_joins(:time_logs)&.group('issues.assignee_id')&.select("issues.*, sum(time_logs.logged_time) as total_time_spent, count(*) AS total_issues, count('#{Issue::STATUS[:resloved]}') as resolved_issues, sum(estimated_time) as total_estimated_time") if sprint.present?
  end

  def self.issues_report_data(sprint)
    @sprint_report_attributes = sprint&.issues&.order(assignee_id: :desc)
  end
end