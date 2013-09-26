class AddExpectedHttpStatusCodeToHostingAccounts < ActiveRecord::Migration
  def change
    add_column :hosting_accounts, :expected_http_status_code, :string, default: '200', null: false
  end
end
