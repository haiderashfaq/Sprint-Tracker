# app/helpers/issues_helper

module IssuesHelper
  def filter_select(form, params)
    if params[:project_id].present?
      filters = Issue::FILTER.except(:Project)
    else
      filters = Issue::FILTER
    end
    form.select t('filter.filter_label'), filters, { include_blank: true }, { class: 'js-select-field js-filter-field form-select form-select-lg' }
  end

  def random_charkick_id
    return 'chart-#'+(Random.rand(10000)).to_s
  end
end
