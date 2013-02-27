class EmailAddress < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :user

  validates_presence_of :address
end
