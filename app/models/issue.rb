class Issue < ActiveRecord::Base
  belongs_to :assignee, class_name: 'User'
  belongs_to :setter, class_name: 'User'
  belongs_to :organisation

  has_many :comments, -> { order 'created_at ASC' }

  validates_presence_of :title
  validates :priority, inclusion: { in: 1..5 }
  validates :assignee_id, presence: true
  validates :setter_id, presence: true
  validates :organisation_id, presence: true

  def to_s
    "##{id}: #{title}"
  end

  # Returns date_due for interoperability with simple_calendar
  def start_time
    date_due || Date.today
  end

  def watchers
    [assignee, setter]
  end
end
