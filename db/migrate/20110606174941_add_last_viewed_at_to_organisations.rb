class AddLastViewedAtToOrganisations < ActiveRecord::Migration
  def self.up
    add_column :organisations, :last_viewed_at, :datetime
    add_index :organisations, :last_viewed_at
  end

  def self.down
    remove_column :organisations, :last_viewed_at
  end
end
