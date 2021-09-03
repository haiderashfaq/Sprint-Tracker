class ChangeForeignKeyForCompany < ActiveRecord::Migration[6.1]
  def change
    rename_column :companies, :user_id, :owner_id
  end
end
