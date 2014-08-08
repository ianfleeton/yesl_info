class AddArchivedToOrganisation < ActiveRecord::Migration
  def change
    add_column :organisations, :archived, :boolean, default: false, null: false
  end
end
