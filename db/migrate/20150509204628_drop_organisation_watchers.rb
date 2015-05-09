class DropOrganisationWatchers < ActiveRecord::Migration
  def change
    drop_table :organisation_watchers
  end
end
