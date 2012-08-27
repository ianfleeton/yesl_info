class CreateToDos < ActiveRecord::Migration
  def change
    create_table :to_dos do |t|
      t.integer :organisation_id, null: false
      t.integer :setter_id, null: false
      t.integer :assignee_id, null: false
      t.integer :priority
      t.date :date_due
      t.boolean :completed, null: false
      t.string :title, null: false
      t.text :details
      t.integer :estimated_time

      t.timestamps
    end
  end
end
