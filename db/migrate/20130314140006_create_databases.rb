class CreateDatabases < ActiveRecord::Migration
  def change
    create_table :databases do |t|
      t.string :host
      t.string :name
      t.string :username
      t.string :password
      t.integer :organisation_id
      t.string :location

      t.timestamps
    end

    add_index :databases, :organisation_id
  end
end
