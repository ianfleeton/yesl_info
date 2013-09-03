class ToDo < ActiveRecord::Base
  belongs_to :assignee, class_name: 'User'
  belongs_to :setter, class_name: 'User'
  belongs_to :organisation

  validates_presence_of :title

  # Returns date_due for interoperability with simple_calendar
  def start_time
    date_due
  end
end
