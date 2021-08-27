class Company < ApplicationRecord
  not_multitenant

  def self.current_company_id=(id)
    Thread.current[:company_id] = id
  end

  def self.current_company_id
    Thread.current[:company_id]
  end

  def self.current_company
    Company.find(current_company_id)
  end
end
