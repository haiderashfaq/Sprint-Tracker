class Report
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