class Project < ApplicationRecord
  include DateValidations
  searchkick word_middle: %i[name], filterable: %i[company_id]
  # merge_mappings: true, mappings: { properties: { company_id: { type: 'keyword' } } }

  before_destroy :check_for_sprints, :check_for_issues

  belongs_to :company
  belongs_to :manager, class_name: 'User'
  belongs_to :creator, class_name: 'User'
  belongs_to :active_sprint, class_name: 'Sprint', optional: true

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

  def pending_sprints
    sprints.includes(:issues).where(status: Sprint::STATUS[:PLANNING]).order(:start_date, :created_at)
  end

  def backlog_issues
    issues.where(sprint: nil)
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
