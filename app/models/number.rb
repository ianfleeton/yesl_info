class Number < ActiveRecord::Base
  belongs_to :organisation, touch: true
  belongs_to :user, touch: true

  validates_presence_of :number
  validates_inclusion_of :tel_type, in: ['fax', 'mob', 'tel']
end
