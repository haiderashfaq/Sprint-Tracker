class Report
  include TimeProgressions
  SPRINT_HEADERS = %w[assignee_name total_issues resolved_issues total_estimated_time total_time_spent].freeze
  ISSUE_HEADERS = %w[status title assignee_name priority category estimated_time total_time_spent].freeze
end