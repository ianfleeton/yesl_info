class Organisation < ActiveRecord::Base
  has_many :domains, :order => :name, :dependent => :destroy
  has_many :users, :order => :name, :dependent => :destroy
  has_many :addresses, :dependent => :delete_all
  has_many :note_pads, :dependent => :destroy
  has_many :timesheet_entries, :dependent => :delete_all
  validates_presence_of :name
end
