class RenameTelTypeToTeltype < ActiveRecord::Migration
  def change
    rename_column :numbers, :tel_type, :teltype
  end
end
