class ToDo < ActiveRecord::Base
  attr_accessible :assignee_id, :completed, :date_due, :details, :estimated_time, :organisation_id, :priority, :setter_id, :title

  belongs_to :assignee, class_name: 'User'
  belongs_to :setter, class_name: 'User'
  belongs_to :organisation

  validates_presence_of :title
end
