class Database < ActiveRecord::Base
  belongs_to :organisation, touch: true

  validates_presence_of :host
  validates_presence_of :name
  validates_presence_of :organisation
  validates_presence_of :password
  validates_presence_of :username
end
