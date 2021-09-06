class Project < ApplicationRecord
  belongs_to :company
  belongs_to :manager, class_name: 'User'
  belongs_to :owner, class_name: 'User'

  has_many :sprints
  has_many :projects_users
  has_many :users, through: :projects_users

  sequenceid :company, :projects
  validate :start_date_before_end_date
  validates :name, :manager_id, :owner_id, presence: true
  validates :name, length: { maximum: 100, minimum: 4 }

  private

  def start_date_before_end_date
    return true if end_date.nil? || start_date < end_date

    errors.add(:end_date, "Can\'t be before starting date")
  end
end
