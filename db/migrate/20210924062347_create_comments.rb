class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :description
      t.bigint :commentable_id
      t.string :commentable_type
      t.references :commenter, null: false, foreign_key: { to_table: :users }
      t.references :company, null: false, foreign_key: true
      t.timestamps
    end
    add_index :comments, %i[commentable_type commentable_id]
  end
end
