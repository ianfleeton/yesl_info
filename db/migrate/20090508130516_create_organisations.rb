class CreateOrganisations < ActiveRecord::Migration
  def self.up
    create_table :organisations do |t|
      t.string :name, :default => '', :null => false
      t.datetime :last_contacted, :default => '0000-00-00 00:00:00', :null => false
      t.integer :contact_cycle, :default => 90, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :organisations
  end
end
