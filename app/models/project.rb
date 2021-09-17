class Project < ApplicationRecord
  belongs_to :company
  belongs_to :manager, class_name: 'User'
  belongs_to :creator, class_name: 'User'
  belongs_to :active_sprint, class_name: 'Sprint', optional: true

  # validate :start_date_before_end_date
  validates :name, :manager, :creator, presence: true
  validates :name, length: { maximum: 100, minimum: 4 }
  has_many :issues

  has_many :sprints
  has_many :projects_users
  has_many :issues
  has_many :users, through: :projects_users, dependent: :destroy

  include DateValidations
  sequenceid :company, :projects
  validates :name, :manager_id, :creator_id, presence: true
  validates :name, length: { maximum: 100, minimum: 4 }
  validate_dates :start_date, :end_date

  before_destroy :check_for_sprints, :check_for_issues

  def self.issues_estimated_time
    @projects = Project.joins('INNER JOIN issues ON issues.project_id = projects.id')
    total_time = 0
    @projects[0].issues.each do |issue|
        total_time += issue.estimated_time
      end
    total_time
  end

  def self.issues_logged_time
    @projects = Project.joins('INNER JOIN issues ON issues.project_id = projects.id')
    total_time = 0
    @projects[0].issues.each do |issue|
      total_time += Issue.time_logs_sum(issue)
    end
    total_time
  end

  def self.fetch_issues
    @projects = Project.joins('INNER JOIN issues ON issues.project_id = projects.id')
    @projects[0].issues
  end

  private

  def check_for_sprints
    return unless sprints.exists?

    errors.add(:base, I18n.t('projects.deletion_error'))
    throw :abort
  end

  def check_for_issues
    return unless issues.exists?

    errors.add(:base, I18n.t('issues.deletion_error'))
    throw :abort
  end
end
