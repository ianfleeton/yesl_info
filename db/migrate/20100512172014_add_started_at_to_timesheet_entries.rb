class AddStartedAtToTimesheetEntries < ActiveRecord::Migration
  def self.up
    add_column :timesheet_entries, :started_at, :datetime, :default => '0000-00-00 00:00:00', :null => false
    add_index :timesheet_entries, :started_at
  end

  def self.down
    remove_column :timesheet_entries, :started_at
  end
end
