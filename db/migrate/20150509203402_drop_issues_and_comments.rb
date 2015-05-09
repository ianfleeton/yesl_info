class DropIssuesAndComments < ActiveRecord::Migration
  def change
    drop_table :issues
    drop_table :comments
  end
end
