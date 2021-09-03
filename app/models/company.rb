class Company < ApplicationRecord
  not_multitenant
  belongs_to :owner, class_name: 'User', optional: true
  has_many :users
  has_many :projects

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
