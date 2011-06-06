class Number < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :user

  validates_presence_of :number
  validates_inclusion_of :number, :in => ['fax', 'mob', 'tel']
end
