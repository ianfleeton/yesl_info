class TimesheetEntry < ActiveRecord::Base
  #validates_presence_of :description, :user_id, :organisation_id
  belongs_to :user
end
