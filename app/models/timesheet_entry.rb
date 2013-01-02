class TimesheetEntry < ActiveRecord::Base
  #validates_presence_of :description, :user_id, :organisation_id
  attr_accessible :chargeable, :description, :invoice_value, :minutes, :organisation_id, :started_at, :user_id

  belongs_to :user, touch: true
  belongs_to :organisation, touch: true
end
