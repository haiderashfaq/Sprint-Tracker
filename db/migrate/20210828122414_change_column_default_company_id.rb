class ChangeColumnDefaultCompanyId < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :company_id, :bigint, default: 0
  end
end
