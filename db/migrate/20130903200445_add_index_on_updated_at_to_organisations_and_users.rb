class AddIndexOnUpdatedAtToOrganisationsAndUsers < ActiveRecord::Migration
  def change
    add_index :organisations, :updated_at
    add_index :users, :updated_at
  end
end
