class Sprint < ApplicationRecord
  belongs_to :company
  belongs_to :project
  belongs_to :creator, class_name: 'User'
  sequenceid :project, :sprints

  has_many :issues
  has_many :sprintreport

  include DateValidations
  VALID_STATUSES = %w[Planning Active Closed].freeze

  validates :name, :project_id, :start_date, :end_date, :creator_id, presence: true
  validate_dates :start_date, :end_date
  validate_dates :estimated_start_date, :estimated_end_date
  validates :status, inclusion: { in: VALID_STATUSES }

  def self.activate_sprint(sprint)
    if sprint.project.active_sprint.nil? && Sprint.where(status: VALID_STATUSES[1]).blank?
      sprint.update(status: VALID_STATUSES[1]) if sprint.project.update(active_sprint: sprint)
    else
      sprint.errors.add :project, I18n.t('sprints.active_sprint_exists')
      false
    end
  end

  def self.complete_sprint(sprint, project, issues, issues_dest_id)
    Sprint.transaction do
      Sprint.generate_report(sprint)
      issues.each do |issue|
        Sprintreport.where(sprint: sprint, issue: issue)&.update(status: "moved", moved_to_id: issues_dest_id)
      end
      issues_dest_id.blank? ? issues.update(sprint: nil) : issues.update(sprint_id: issues_dest_id)
      project.update(active_sprint: nil)
      sprint.update(status: VALID_STATUSES[2])
    end
  end

  def self.generate_report(sprint)
    sprint.transaction do
      sprint.issues.each do |issue|
        sprintreport = Sprintreport.new
        sprintreport.sprint = sprint
        sprintreport.issue = issue
        sprintreport.issue = issue
        sprintreport.status = issue.status == 'Resolved' ? 'closed' : 'in_progress'
        sprintreport.save
      end
    end
  end
end
