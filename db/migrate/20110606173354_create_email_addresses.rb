class CreateEmailAddresses < ActiveRecord::Migration
  def self.up
    create_table :email_addresses do |t|
      t.integer :organisation_id
      t.integer :user_id
      t.string :address, :default => '', :null => false
      t.string :password, :default => '', :null => false

      t.timestamps
    end

    add_index :email_addresses, :organisation_id
    add_index :email_addresses, :user_id
  end

  def self.down
    drop_table :email_addresses
  end
end
