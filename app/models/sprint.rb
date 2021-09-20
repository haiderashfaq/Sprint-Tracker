class Sprint < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :creator, class_name: 'User'
  sequenceid :project, :sprints

  has_many :issues
  has_many :sprintreport

  include DateValidations
  STATUS = { PLANNING: 'PLANNING', ACTIVE: 'ACTIVE', CLOSED: 'CLOSED' }.freeze

  validates :name, :project_id, :start_date, :end_date, :creator_id, presence: true
  validate_dates :start_date, :end_date
  validate_dates :estimated_start_date, :estimated_end_date
  validates :status, inclusion: { in: STATUS.values }

  def total_spent_time
    issues.joins(:time_logs).sum(:logged_time)
  end

  def total_estimated_time
    issues.sum(:estimated_time)
  end

  def self.activate_sprint(sprint)
    begin
      sprint.transaction do
        if sprint.project.active_sprint.nil? && Sprint.where(status: Sprint::STATUS[:ACTIVE]).blank?
          if sprint.project.update(active_sprint: sprint)
            sprint.update(status: Sprint::STATUS[:ACTIVE])
          end
        else
          sprint.errors.add :project, I18n.t('sprints.active_sprint_exists')
          false
        end
      end
    rescue ActiveRecord::RecordInvalid => invalid
      sprint.errors.add invalid.record.errors.full_messages
    end
  end

  def self.complete_sprint(sprint, project, issues, issues_dest_id)
    begin
      sprint.transaction do
        Sprint.generate_report(sprint)
        issues.each do |issue|
          Sprintreport.find_by(sprint: sprint, issue: issue).update(status: Sprintreport::STATUS[:MOVED], moved_to_id: issues_dest_id)
        end
        issues_dest_id.blank? ? issues.update(sprint: nil) : issues.update(sprint_id: issues_dest_id)
        project.update!(active_sprint: nil)
        sprint.update!(status: Sprint::STATUS[:CLOSED])
      end
    rescue ActiveRecord::RecordInvalid => invalid
      sprint.errors.add invalid.record.errors.full_messages
    end
  end

  def self.generate_report(sprint)
    begin
      sprint.transaction(requires_new: true) do
        sprint.issues.each do |issue|
          Sprintreport.create!(sprint: sprint, issue: issue, status: (issue.status == Issue::STATUS['Resolved'] ? Sprintreport::STATUS[:CLOSED] : Sprintreport::STATUS[:IN_PROGRESS]))
        end
      end
    rescue ActiveRecord::RecordInvalid => invalid
      sprint.errors.add invalid.record.errors.full_messages
    end
  end

  def self.get_project_resolved_and_unresolved_issues(sprint)
    project = sprint.project
    issues_unresolved = sprint.issues.where.not(status: Issue::STATUS['Resolved'])
    issues_resolved = sprint.issues.where(status: Issue::STATUS['Resolved'])
    [project, issues_unresolved, issues_resolved]
  end

  def self.report_content(sprint)
    issues_unresolved = sprint.sprintreport.where.not(status: Sprintreport::STATUS[:CLOSED]).pluck(:issue_id)
    issues_resolved = sprint.sprintreport.where(status: Sprintreport::STATUS[:CLOSED]).pluck(:issue_id)
    issues_unresolved = Issue.where(id: issues_unresolved)
    issues_resolved = Issue.where(id: issues_resolved)
    [issues_resolved, issues_unresolved]
  end
end
