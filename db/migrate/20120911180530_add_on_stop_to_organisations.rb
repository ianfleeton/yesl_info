class AddOnStopToOrganisations < ActiveRecord::Migration
  def change
    add_column :organisations, :on_stop, :boolean, default: false, null: false
  end
end
