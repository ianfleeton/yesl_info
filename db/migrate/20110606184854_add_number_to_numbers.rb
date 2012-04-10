class AddNumberToNumbers < ActiveRecord::Migration
  def self.up
    add_column :numbers, :number, :string, :default => '', :null => false
  end

  def self.down
    remove_column :numbers, :number
  end
end
