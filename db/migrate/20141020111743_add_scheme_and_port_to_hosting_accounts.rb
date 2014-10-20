class AddSchemeAndPortToHostingAccounts < ActiveRecord::Migration
  def change
    add_column :hosting_accounts, :scheme, :string, default: 'http', null: false
    add_column :hosting_accounts, :port, :integer, default: 80, null: false
  end
end
