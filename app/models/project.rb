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

  def sprints_and_issues
    sprints = self.sprints.includes(:issues).where(status: Sprint::STATUS[:PLANNING]).order(:start_date, :created_at)
    issues = self.issues.where(sprint: nil)
    [sprints, issues]
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
