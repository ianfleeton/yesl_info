class Number < ActiveRecord::Base
  attr_accessible :note, :number, :organisation_id, :tel_type, :user_id

  belongs_to :organisation, touch: true
  belongs_to :user, touch: true

  validates_presence_of :number
  validates_inclusion_of :tel_type, in: ['fax', 'mob', 'tel']
end
