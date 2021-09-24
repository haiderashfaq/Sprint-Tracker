class Sprint < ApplicationRecord
  searchkick word_middle: %i[name description], filterable: %i[company_id]
  include DateValidations

  belongs_to :company
  belongs_to :project
  belongs_to :creator, class_name: 'User'
  sequenceid :company, :sprints

  has_many :issues
  has_many :sprintreport

  STATUS = { PLANNING: 'PLANNING', ACTIVE: 'ACTIVE', CLOSED: 'CLOSED' }.freeze

  validates :name, :project_id, :start_date, :end_date, :creator_id, presence: true
  validate_datetime :start_date
  validate_datetime :end_date
  validate_datetime :estimated_start_date
  validate_datetime :estimated_end_date
  validate_dates :start_date, :end_date
  validate_dates :estimated_start_date, :estimated_end_date
  validates :status, inclusion: { in: STATUS.values }

  before_destroy :check_for_issues, prepend: true

  def total_time_spent
    issues.joins(:time_logs).sum(:logged_time)
  end

  def total_estimated_time
    issues.sum(:estimated_time)
  end

  def activate_sprint
    begin
      transaction do
        if project.active_sprint.nil?
          if project.update(active_sprint: self)
            update(status: Sprint::STATUS[:ACTIVE])
          end
        else
          errors.add :project, I18n.t('sprints.active_sprint_exists')
          false
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      errors.add :base, e.record.errors.full_messages
    end
  end

  def complete_sprint(issues, issues_dest_id)
    begin
      transaction do
        generate_report unless Sprintreport.find_by(sprint_id: id)
        issues.each do |issue|
          Sprintreport.find_by(sprint: self, issue: issue).update(status: Sprintreport::STATUS[:MOVED], moved_to_id: issues_dest_id)
        end
        issues_dest_id.blank? ? issues.update(sprint: nil) : issues.update(sprint_id: issues_dest_id)
        project.update!(active_sprint: nil)
        update!(status: Sprint::STATUS[:CLOSED])
      end
    rescue ActiveRecord::RecordInvalid => e
      errors.add :base, e.record.errors.full_messages
    end
  end

  def generate_report
    begin
      transaction(requires_new: true) do
        issues.each do |issue|
          Sprintreport.create!(sprint: self, issue: issue, status: (issue.status == Issue::STATUS.invert['Closed'] ? Sprintreport::STATUS[:CLOSED] : Sprintreport::STATUS[:IN_PROGRESS]))
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      errors.add :base, e.record.errors.full_messages
    end
  end

  def resolved_and_unresolved_issues
    issues_unresolved = issues.where.not(status: Issue::STATUS.invert['Closed'])
    issues_resolved = issues.where(status: Issue::STATUS.invert['Closed'])
    [issues_unresolved, issues_resolved]
  end

  def report_content
    generate_report unless Sprintreport.find_by(sprint_id: id)
    issues_unresolved = sprintreport.includes(:issue).where.not(status: Sprintreport::STATUS[:CLOSED])
    issues_resolved = sprintreport.includes(:issue).where(status: Sprintreport::STATUS[:CLOSED])
    [issues_resolved, issues_unresolved]
  end

  def categorized_issues
    issues_to_do = issues.where(status: Issue::STATUS.invert['Open'])
    issues_in_progress = issues.where(status: Issue::STATUS.invert['In Progress'])
    issues_resolved = issues.where(status: Issue::STATUS.invert['Resolved'])
    issues_closed = issues.where(status: Issue::STATUS.invert['Closed'])
    [issues_to_do, issues_in_progress, issues_resolved, issues_closed]
  end

  private

  def check_for_issues
    return unless issues.exist?

    errors.add(:base, I18n.t('sprints.sprint_deletion_error'))
    throw :abort
  end
end
