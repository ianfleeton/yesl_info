class AddWithUsToDomains < ActiveRecord::Migration
  def self.up
    remove_column :domains, :web_host_id
    add_column :domains, :with_us, :boolean, :default => true, :null => false
    add_index :domains, :organisation_id
  end

  def self.down
    remove_index :domains, :organisation_id
    remove_column :domains, :with_us
    add_column :domains, :web_host_id, :integer, :default => 0, :null => false
  end
end
