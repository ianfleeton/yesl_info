class Organisation < ActiveRecord::Base
  has_many :domains, :order => :name, :dependent => :destroy
  has_many :users, :order => :name, :dependent => :destroy
  has_many :addresses, :dependent => :delete_all
  has_many :email_addresses, :dependent => :delete_all
  has_many :note_pads, :dependent => :destroy
  has_many :numbers, :dependent => :delete_all
  has_many :timesheet_entries, :dependent => :delete_all

  scope :recently_viewed, :order => 'last_viewed_at DESC', :limit => 10

  validates_presence_of :name
end
