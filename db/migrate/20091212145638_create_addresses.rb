class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.integer :organisation_id, :default => 0, :null => false
      t.string :address_line_1, :default => '', :null => false
      t.string :address_line_2, :default => '', :null => false
      t.string :town_city, :default => '', :null => false
      t.string :county, :default => '', :null => false
      t.string :postcode, :default => '', :null => false

      t.timestamps
    end
    add_index :addresses, :organisation_id
  end

  def self.down
    drop_table :addresses
  end
end
