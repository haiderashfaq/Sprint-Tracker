class Company < ApplicationRecord
  not_multitenant

  has_many :users, dependent: :destroy
  validates :subdomain, uniqueness: true
  belongs_to :owner, class_name: "User", optional: true
  has_many :issues, dependent: :destroy
  has_many :projects
  validates :name, uniqueness: true
  validates :subdomain, uniqueness: true

  def self.current_company_id=(id)
    Thread.current[:company_id] = id
  end

  def self.create_symbol!(user_params)
    Company.transaction do
      user = User.new(user_params)
      user.company.owner = user # resource will be an instance of User
      user.role_id = User::ROLE_ID[:admin]
      user.save!
      stored_subdomain = user.company.subdomain
    end
  end

  def self.current_company_id
    Thread.current[:company_id]
  end

  def self.current_company
    Company.find_by(id: current_company_id)
  end
end
