class RenameToDosToIssues < ActiveRecord::Migration
  def change
    rename_table :to_dos, :issues
  end
end
