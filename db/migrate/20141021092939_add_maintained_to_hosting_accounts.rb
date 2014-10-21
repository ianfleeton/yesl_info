class AddMaintainedToHostingAccounts < ActiveRecord::Migration
  def change
    add_column :hosting_accounts, :maintained, :boolean, default: true, null: false
  end
end
