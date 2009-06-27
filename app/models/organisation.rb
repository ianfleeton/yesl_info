class Organisation < ActiveRecord::Base
  has_many :domains
  validates_presence_of :name
end
