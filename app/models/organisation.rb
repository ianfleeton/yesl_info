class Organisation < ActiveRecord::Base
  include Initials

  has_many :databases, dependent: :delete_all
  has_many :domains, -> { order 'name' }, dependent: :destroy
  has_many :users, -> { order 'name' }, dependent: :destroy
  has_many :addresses, dependent: :delete_all
  has_many :email_addresses, -> { order 'address' }, dependent: :delete_all
  has_many :note_pads, dependent: :destroy
  has_many :numbers, dependent: :delete_all
  has_many :timesheet_entries, -> { order('started_at DESC').includes(:user) }, dependent: :delete_all

  scope :recently_viewed, -> { order('last_viewed_at DESC').limit(10) }

  validates_presence_of :name

  acts_as_taggable

  def to_s
    name
  end

  def revenue_per_hour
    minutes = minutes_logged
    return 0 if 0 == minutes
    invoice_value / (minutes / 60.0)
  end

  def invoice_value
    timesheet_entries
      .where('chargeable = 1 AND started_at >= DATE_SUB(NOW(), INTERVAL 2 YEAR)')
      .sum('invoice_value')
  end

  def minutes_logged
    timesheet_entries
      .where('started_at >= DATE_SUB(NOW(), INTERVAL 2 YEAR)')
      .sum('minutes')
  end
end
