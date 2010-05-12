class CreateHostingAccounts < ActiveRecord::Migration
  def self.up
    create_table :hosting_accounts do |t|
      t.integer :domain_id, :default => 0, :null => false
      t.string :ftp_host, :default => '', :null => false
      t.string :username, :default => '', :null => false
      t.string :password, :default => '', :null => false
      t.date :started_on, :default => '0000-00-00', :null => false
      t.string :host_name, :default => '', :null => false
      t.date :backed_up_on, :default => '0000-00-00', :null => false
      t.integer :backup_cycle, :default => 14, :null => false
      t.decimal :annual_fee, :precision => 6, :scale => 2, :default => 0, :null => false

      t.timestamps
    end
    add_index :hosting_accounts, :domain_id
  end

  def self.down
    drop_table :hosting_accounts
  end
end
