class EmailAddress < ActiveRecord::Base
  attr_accessible :organisation_id, :user_id, :address, :password

  belongs_to :organisation
  belongs_to :user

  validates_presence_of :address
end
