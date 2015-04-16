class CreateTimesheetEntries < ActiveRecord::Migration
  def self.up
    create_table :timesheet_entries do |t|
      t.integer :organisation_id, :default => 0, :null => false
      t.integer :user_id, :default => 0, :null => false
      t.text :description, :null => false
      t.decimal :invoice_value, :precision => 10, :scale => 2, :default => 0.0, :null => false
      t.boolean :chargeable, :default => false, :null => false
      t.integer :minutes, :default => 0, :null => false

      t.timestamps
    end
    add_index :timesheet_entries, :organisation_id
    add_index :timesheet_entries, :user_id
  end

  def self.down
    drop_table :timesheet_entries
  end
end
