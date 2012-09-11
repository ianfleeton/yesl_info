class HostingAccount < ActiveRecord::Base
  attr_accessible :annual_fee, :backed_up_on, :backup_cycle, :domain_id,
    :ftp_host, :host_name, :started_on, :username, :password

  belongs_to :domain, touch: true
end
