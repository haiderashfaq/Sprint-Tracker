class IssueDecorator < Draper::Decorator
  delegate_all
  def assignee_name
    assignee&.name || I18n.t('issues.no_assignee')
  end

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def get_audits
    audits.includes(:user)
  end
end