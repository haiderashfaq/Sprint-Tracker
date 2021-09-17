class Sprint < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :creator, class_name: 'User'
  sequenceid :project, :sprints

  has_many :issues
  has_many :sprintreport

  include DateValidations
  VALID_STATUSES = [PLANNING, ACTIVE, CLOSED].freeze

  validates :name, :project_id, :start_date, :end_date, :creator_id, presence: true
  validate_dates :start_date, :end_date
  validate_dates :estimated_start_date, :estimated_end_date
  validates :status, inclusion: { in: VALID_STATUSES }

  def self.activate_sprint(sprint)
    if sprint.project.active_sprint.nil? && Sprint.where(status: VALID_STATUSES[1]).blank?
      if sprint.project.update(active_sprint: sprint)
        sprint.update(status: ACTIVE)
      end
    else
      sprint.errors.add :project, I18n.t('sprints.active_sprint_exists')
      false
    end
  end

  def self.complete_sprint(sprint, project, issues, issues_dest_id)
    Sprint.transaction do
      Sprint.generate_report(sprint)
      issues.each do |issue|
        Sprintreport.find_by(sprint: sprint, issue: issue).update(status: MOVED, moved_to_id: issues_dest_id)
      end
      issues_dest_id.blank? ? issues.update(sprint: nil) : issues.update(sprint_id: issues_dest_id)
      project.update!(active_sprint: nil)
      sprint.update!(status: CLOSED)
    end
  end

  def self.generate_report(sprint)
    sprint.transaction(requires_new: true) do
      sprint.issues.each do |issue|
        Sprintreport.create!(sprint: sprint, issue: issue, status: (issue.status == RESOLVED ? CLOSED : IN_PROGRESS))
      end
    end
  end

  def self.get_project_resolved_and_unresolved_issues(sprint)
    project = sprint.project
    issues_unresolved = sprint.issues.where.not(status: RESOLVED)
    issues_resolved = sprint.issues.where(status: RESOLVED)
    [project, issues_unresolved, issues_resolved]
  end

  def self.report_content(sprint)
    issues_unresolved = sprint.sprintreport.where.not(status: CLOSED).pluck(:issue_id)
    issues_resolved = sprint.sprintreport.where(status: CLOSED).pluck(:issue_id)
    issues_unresolved = Issue.where(id: issues_unresolved)
    issues_resolved = Issue.where(id: issues_resolved)
    [issues_resolved, issues_unresolved]
  end
end
