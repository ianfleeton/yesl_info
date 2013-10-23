class AddDefaultToIssueCompleted < ActiveRecord::Migration
  def up
    change_column :issues, :completed, :boolean, default: false, null: false
  end

  def down
    change_column :issues, :completed, :boolean, null: false
  end
end
