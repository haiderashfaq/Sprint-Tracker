class ChangeFirstNameNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :first_name, false, Time.now
  end
end
