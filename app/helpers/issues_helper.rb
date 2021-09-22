# app/helpers/issues_helper

module IssuesHelper
  STATUS_COLOR = { Open: 'primary', 'In Progress'.to_sym => 'danger', Resolved: 'info', Closed: 'success' }.freeze
  PRIORITY_COLOR = { Low: 'success', Medium: 'warning', High: 'danger' }.freeze
  CATEGORY_COLOR = { Hotfix: 'warning', Feature: 'info' }.freeze

  def filter_select(form, params)
    if params[:project_id].present?
      filters = Issue::FILTER.except(:Project)
    else
      filters = Issue::FILTER
    end
    form.select t('filter.filter_label'), filters, { include_blank: true }, { class: 'js-select-field js-filter-field form-select form-select-lg' }
  end

  def user_name(value)
    value[0] = User.find_by(id: value[0].to_i).name
    value[1] = User.find_by(id: value[1].to_i).name
    value
  end

  def date_format(value)
    value[0] = convert_to_date(value[0])
    value[1] = convert_to_date(value[1])
    value
  end

  def string_format(value)
    value[0] = value[0].to_s
    value[1] = value[1].to_s
    value
  end

  def set_format(attribute, value)
    value = user_name(value) if %w[creator_id reviewer_id assignee_id].include?(attribute)
    value = date_format(value) if %w[estimated_start_date estimated_end_date actual_start_date actual_end_date].include?(attribute)
    value = string_format(value) unless %w[estimated_start_date estimated_end_date actual_start_date actual_end_date].include?(attribute)
    value
  end

  def convert_to_date(date)
    date&.to_date&.to_s(:long)
  end
end
