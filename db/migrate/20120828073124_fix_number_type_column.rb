class FixNumberTypeColumn < ActiveRecord::Migration
  def change
    rename_column :numbers, :type, :tel_type
  end
end
