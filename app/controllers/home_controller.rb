class HomeController < ApplicationController
  before_action :admin_required, except: [:home]

  def index
    @backups_pending = HostingAccount.where('backed_up_on < DATE_SUB(NOW(), INTERVAL backup_cycle DAY)').count
    @contacts = Organisation.where('last_contacted < DATE_SUB(NOW(), INTERVAL contact_cycle DAY)').count
  end

  def links
    @timesheet_entries = TimesheetEntry
      .where('description LIKE "%http%" AND started_at >= DATE_SUB(NOW(), INTERVAL 180 DAY)')
      .order('started_at DESC')
  end

  def passwords
    @passwords = Array.new
    10.times {@passwords << create_password}
  end

  def webpanel_logins
    ActiveRecord::Base.establish_connection(
      adapter:  'mysql2',
      host:     'straylight.yesl.co.uk',
      username: 'webpanel_panel',
      password: 'VDfTZuh6L1EB',
      database: 'webpanel_panel'
    )
    @logins =  ActiveRecord::Base.connection.select_rows("SELECT username, password FROM users ORDER BY username")
    ActiveRecord::Base.establish_connection(Rails.env)
  end

  private
  
    def create_password
      SecureRandom.base64(9)
    end
end
