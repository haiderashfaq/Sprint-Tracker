class CreateWatchers < ActiveRecord::Migration[6.1]
  def change
    create_table :watchers do |t|
      t.timestamps
      t.integer :user_id, index: true, foreign_key: true
      t.integer :issue_id, index: true, foreign_key: true
      t.references :company, null: false, foreign_key: true

    end
  end
end