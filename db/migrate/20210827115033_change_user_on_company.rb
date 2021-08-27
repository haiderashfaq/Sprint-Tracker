class ChangeUserOnCompany < ActiveRecord::Migration[6.1]
  def change
    change_column :companies, :user_id, :bigint, null: true
  end
end
