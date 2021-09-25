class Company < ApplicationRecord
  not_multitenant

  has_many :users, dependent: :destroy
  validates :subdomain, uniqueness: true
  belongs_to :owner, class_name: "User", optional: true
  has_many :issues, dependent: :destroy
  has_many :projects
  has_many :sprints
  has_many :comments
  validates :name, uniqueness: true
  validates :subdomain, uniqueness: true

  def self.current_company_id=(id)
    Thread.current[:company_id] = id
  end

  def self.current_company_id
    Thread.current[:company_id]
  end

  def self.current_company
    Company.find_by(id: current_company_id)
  end
end
