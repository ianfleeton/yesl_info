class CreateNotePads < ActiveRecord::Migration
  def self.up
    create_table :note_pads do |t|
      t.integer :organisation_id, :default => 0, :null => false
      t.string :title, :default => '', :null => false
      t.text :content, :default => '', :null => false

      t.timestamps
    end
    add_index :note_pads, :organisation_id
  end

  def self.down
    drop_table :note_pads
  end
end
