class CreateOrganisationWatchers < ActiveRecord::Migration
  def change
    create_table :organisation_watchers do |t|
      t.integer :organisation_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :organisation_watchers, :organisation_id
    add_index :organisation_watchers, :user_id
  end
end
