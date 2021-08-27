class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name,       null: false
      t.string :subdomain,  null: false
      t.references :user,   null: false

      t.timestamps
    end
    add_index :companies, :subdomain
  end
end
