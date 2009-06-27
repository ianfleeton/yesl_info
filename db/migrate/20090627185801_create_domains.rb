class CreateDomains < ActiveRecord::Migration
  def self.up
    create_table :domains do |t|
      t.integer :organisation_id, :default => 0, :null => false
      t.string :name, :default => '', :null => false
      t.integer :web_host_id, :default => 0, :null => false
      t.integer :forwarding_id
      t.date :registered_on, :default => '0000-00-00', :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :domains
  end
end
