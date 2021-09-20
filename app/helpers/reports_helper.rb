module ReportsHelper
  def getValue(estimated_time, time_spent)
    value = [estimated_time, time_spent].min / [estimated_time, time_spent].max
    value = value.to_f * 100
  end
end
