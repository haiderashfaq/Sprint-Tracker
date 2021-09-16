# app/helpers/issues_helper

module IssuesHelper
  def filter_select(form, params)
    if params[:project_id].present?
      form.select t('filter.filter_label'), Issue::FILTER.except(:Project), { include_blank: true }, { class: 'js-select-field js-filter-field form-select form-select-lg' } 
    else
      form.select t('filter.filter_label'), Issue::FILTER, { include_blank: true }, { class: 'js-select-field js-filter-field form-select form-select-lg' }
    end
  end
end
