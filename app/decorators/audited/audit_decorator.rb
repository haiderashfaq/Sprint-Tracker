module Audited
  class AuditDecorator < Draper::Decorator
    delegate_all

    def previous_value(attribute, value)
      set_format(attribute, value)
    end

    def new_value(attribute, value)
      set_format(attribute, value)
    end

    private
    def get_user_name(value)
      User.find_by(id: value.to_i).name if User.find_by(id: value.to_i).present?
    end

    def date_format(value)
      convert_to_date(value)
    end

    def convert_to_date(date)
      date&.to_date&.to_s(:long)
    end

    def string_format(value)
      value.to_s
    end

    def set_format(attribute, value)
      value = get_user_name(value) if %w[creator_id reviewer_id assignee_id].include?(attribute)
      value = date_format(value) if %w[estimated_start_date estimated_end_date actual_start_date actual_end_date].include?(attribute)
      value = string_format(value) unless %w[estimated_start_date estimated_end_date actual_start_date actual_end_date].include?(attribute)
      value
    end
  end
end
