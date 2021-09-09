module DateValidations
  extend ActiveSupport::Concern

  included do
    class << self
      def validate_dates(start_date_column, end_date_column)
        validate do
          start_date = public_send start_date_column
          end_date = public_send end_date_column

          if start_date.present? && end_date.present? && start_date > end_date
            errors.add(end_date_column, "can't be before #{start_date_column.to_s.humanize}")
          end
        end
      end
    end
  end
end
