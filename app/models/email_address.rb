class EmailAddress < ActiveRecord::Base
  belongs_to :organisation, touch: true
  belongs_to :user, touch: true

  validates_presence_of :address
end
