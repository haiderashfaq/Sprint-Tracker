# app/helpers/issues_helper

module IssuesHelper

  def get_status_color(status)
    status_color = { Open: 'primary', 'In Progress'.to_sym => 'danger', Resolved: 'info', Closed: 'success' }
    status_color[status.to_sym]
  end

  def get_priority_color(priority)
    priority_color = { Low: 'success', Medium: 'warning', High: 'danger' }
    priority_color[priority.to_sym]
  end

  def get_category_color(category)
    category_color = { Hotfix: 'warning', Feature: 'info' }
    category_color[category.to_sym]
  end

  def filter_select(form, params)
    if params[:project_id].present?
      filters = Issue::FILTER.except(:Project)
    else
      filters = Issue::FILTER
    end
    form.select t('filter.filter_label'), filters, { include_blank: true }, { class: 'js-select-field js-filter-field form-select form-select-lg' }
  end

  def date_format(value)
    date = []
    date[0] = convert_to_date(value[0])
    date[1] = convert_to_date(value[1])
    date
  end

  def string_format(value)
    string = []
    string[0] = value[0].to_s
    string[1] = value[1].to_s
    string
  end

  def set_format(attribute, value)
    value = Issue.users_name(value) if %w[creator_id reviewer_id assignee_id].include?(attribute)
    value = date_format(value) if %w[estimated_start_date estimated_end_date actual_start_date actual_end_date].include?(attribute)
    value = string_format(value) unless %w[estimated_start_date estimated_end_date actual_start_date actual_end_date].include?(attribute)
    value
  end

  def convert_to_date(date)
    date&.to_date&.to_s(:long)
  end
end
