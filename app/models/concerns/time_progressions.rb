module TimeProgressions
  extend ActiveSupport::Concern

  included do
    def time_progression(logged_time_sum, issue_estimated_time)
      progress_ratio = [logged_time_sum, issue_estimated_time].min / ([logged_time_sum, issue_estimated_time].max.nonzero? || 1)
      progress_ratio.to_f * 100
    end

    def remaining_progression_percentage(time_progression_ratio)
      100 - time_progression_ratio
    end
  end
end
