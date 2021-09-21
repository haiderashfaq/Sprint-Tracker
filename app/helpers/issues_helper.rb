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

  def user_name(attribute, value)
    if %w[creator_id reviewer_id assignee_id].include?(attribute)
      value[0] = User.find(value[0].to_i).name
      value[1] = User.find(value[1].to_i).name
    end
    value
  end
end
