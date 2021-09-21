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

  def issue_badge_pill_selection(status)
    case status
    when Issue::STATUS[:Open] then 'primary'
    when Issue::STATUS[:'In Progress'] then 'danger'
    when Issue::STATUS[:Resolved] then 'info'
    when Issue::STATUS[:Closed] then 'success'
    end
  end

  def issues_priority_pill_selection(priority)
    case priority
    when Issue::PRIORITY[:Low] then 'success'
    when Issue::PRIORITY[:Medium] then 'warning'
    when Issue::PRIORITY[:High] then 'danger'
    end
  end

   def badge_pill_selection(status)
    case status
      when Issue::STATUS[:Open] then 'primary'
      when Issue::STATUS[:'In Progress'] then 'danger'
      when Issue::STATUS[:Resolved] then 'info'
      when Issue::STATUS[:Closed] then 'success'
    end
  end
end
