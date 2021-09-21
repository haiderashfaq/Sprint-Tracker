class ReportCsv
  def initialize(attributes, values)
    @attributes = attributes
    @values = values
  end

  def to_csv
    CSV.generate(headers: true) do |csv|
      csv << @attributes
      @values.each do |report|
        csv << @attributes.map { |attr| report.send(attr) }
      end
    end
  end
end
