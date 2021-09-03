class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name,       null: false
      t.string :subdomain,  null: false
      t.references :owner,  null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :companies, :subdomain
  end
end
