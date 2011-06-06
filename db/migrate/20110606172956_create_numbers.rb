class CreateNumbers < ActiveRecord::Migration
  def self.up
    create_table :numbers do |t|
      t.integer :organisation_id
      t.integer :user_id
      t.string :type, :default => 'tel', :null => false
      t.string :note, :default => '', :null => false

      t.timestamps
    end

    add_index :numbers, :organisation_id
    add_index :numbers, :user_id
  end

  def self.down
    drop_table :numbers
  end
end
