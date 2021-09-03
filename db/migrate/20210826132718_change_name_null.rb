class ChangeNameNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :name, false, Time.now
  end
end
