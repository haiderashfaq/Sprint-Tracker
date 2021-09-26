class CreateWatchers < ActiveRecord::Migration[6.1]
  def change
    create_table :watchers do |t|
      t.timestamps
      t.integer :user_id, index: true
      t.integer :issue_id, index: true
      t.references :company, null: false, foreign_key: true

      add_index [:issue_id, :user_id], unique: true
    end
  end
end