class ToDo < ActiveRecord::Base
  belongs_to :assignee, class_name: 'User'
  belongs_to :setter, class_name: 'User'
  belongs_to :organisation

  validates_presence_of :title
end
