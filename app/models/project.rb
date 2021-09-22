class Project < ApplicationRecord
  include DateValidations
  include TimeProgressions
  searchkick word_middle: [:name]

  before_destroy :check_for_sprints, :check_for_issues

  belongs_to :company
  belongs_to :manager, class_name: 'User'
  belongs_to :creator, class_name: 'User'
  belongs_to :active_sprint, class_name: 'Sprint', optional: true

  # validate :start_date_before_end_date
  before_destroy :check_for_sprints, :check_for_issues

  validates :name, :manager, :creator, presence: true
  validates :name, length: { maximum: 100, minimum: 4 }

  has_many :issues
  has_many :sprints
  has_many :projects_users
  has_many :issues
  has_many :users, through: :projects_users, dependent: :destroy

  sequenceid :company, :projects
  validates :name, :manager, :creator, presence: true
  validates :name, length: { maximum: 100, minimum: 4 }
  validates :name, :manager_id, :creator_id, presence: true
  validates :name, length: { maximum: 100, minimum: 4 }
  validate_dates :start_date, :end_date

  def total_spent_time
    if issues.any?
      issues.sum(:estimated_time)
    end
  end

  def total_logged_time
    TimeLog.joins(:issue).sum(:logged_time)
  end

  def total_spent_time
    total_time = 0
    if issues.any?
      total_time = TimeLog.joins(:issue).sum(:logged_time)
    end
  end

  def total_estimated_time
    total_time = 0
    if issues.any?
      total_time = issues.sum(:estimated_time)
    end
  end

  def self.project_lead_fetch_sprints
    @current_company.projects.where(manager: current_user)
  end

  def sprints_and_issues
    sprints = self.sprints.includes(:issues).where(status: Sprint::STATUS[:PLANNING]).order(:start_date, :created_at)
    issues = self.issues.where(sprint: nil)
    [sprints, issues]
  end

  def pending_sprints
    sprints.includes(:issues).where(status: Sprint::STATUS[:PLANNING]).order(:start_date, :created_at)
  end

  def backlog_issues
    issues.where(sprint: nil)
  end

  def fetch_project_issues

    # TO DO
    if active_sprint.present?
      active_sprint.issues
    end
  end

  def fetch_sprint_issues
    if active_sprint.present?
      active_sprint.issues
    end
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
