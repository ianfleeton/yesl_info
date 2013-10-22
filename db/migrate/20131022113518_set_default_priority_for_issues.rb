class SetDefaultPriorityForIssues < ActiveRecord::Migration
  def up
    change_column :issues, :priority, :integer, null: false, default: 3
  end

  def down
    change_column :issues, :priority, :integer
  end
end
