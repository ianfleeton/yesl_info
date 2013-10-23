class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :issue_id, null: false

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :issue_id
  end
end
