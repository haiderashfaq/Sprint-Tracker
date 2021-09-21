class Report
  SPRINT_HEADERS = %w[assignee_name total_issues open_issues resolved_issues total_estimated_time total_time_spent].freeze
  ISSUE_HEADERS = %w[status title assignee_name priority category estimated_time total_time_spent].freeze

  def self.to_csv
    attributes = %w{name assigned_issues resolved_issues total_estimated_time time_spent}
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |report|
        csv << report.attributes.attributes.map{ |attr| report.send(attr) }
      end
    end
  end
end