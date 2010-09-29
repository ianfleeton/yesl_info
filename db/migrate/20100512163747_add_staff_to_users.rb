class AddStaffToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :staff, :boolean, :default => false, :null => false
    add_index :users, :staff
  end

  def self.down
    remove_column :users, :staff
  end
end
