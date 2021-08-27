class Company < ApplicationRecord
  not_multitenant

  def self.current_company=(id)
    Thread.current[:company_id] = id
  end

  def self.current_company
    Thread.current[:company_id]
  end
end
