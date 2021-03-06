class HomeController < ApplicationController
  before_action :admin_required, except: [:home]

  def index
    @backups_pending = HostingAccount.where('backed_up_on < DATE_SUB(NOW(), INTERVAL backup_cycle DAY)').count
    @contacts = Organisation.where('last_contacted < DATE_SUB(NOW(), INTERVAL contact_cycle DAY)').count

    @home_content = home_content
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

  private

    def create_password
      SecureRandom.base64(9)
    end

    def home_content
      note_pad = NotePad.find_by(title: 'Home Content')
      note_pad ? note_pad.content : ''
    end
end
