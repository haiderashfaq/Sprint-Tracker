class AddPhonenumToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phone_num, :int
  end
end