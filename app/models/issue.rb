class Issue < ActiveRecord::Base
  include IssuesHelper

  belongs_to :assignee, class_name: 'User'
  belongs_to :setter, class_name: 'User'
  belongs_to :organisation

  has_many :comments, -> { order 'created_at ASC' }

  validates_presence_of :title
  validates :priority, inclusion: { in: 1..5 }
  validates :assignee_id, presence: true
  validates :setter_id, presence: true
  validates :organisation_id, presence: true

  after_create :notify_watchers_of_creation

  after_update :add_change_comment

  attr_accessor :updater

  def to_s
    "##{id}: #{title}"
  end

  # Returns date_due for interoperability with simple_calendar
  def start_time
    date_due || Date.today
  end

  def watchers
    ([assignee, setter] + organisation.watchers).uniq
  end

  def notify_watchers_of_creation
    watchers.each do |watcher|
      IssueNotifier.new_task(self, watcher).deliver
    end
  end

  def add_change_comment
    comment = ""
    if details_changed?
      comment += "* edited description\n"
    end
    if title_changed?
      comment += "* edited title\n"
    end
    if priority_changed?
      comment += "* changed priority from #{priority_name(priority_was)} to #{priority_name(priority)}\n"
    end
    if estimated_time_changed?
      comment += "* changed estimated time from #{estimated_time_was}m to #{estimated_time}m\n"
    end
    if date_due_changed?
      comment += "* changed due date from #{date_due_was} to #{date_due}\n"
    end
    if assignee_id_changed?
      comment += "* changed assignee from #{User.find(assignee_id_was)} to #{User.find(assignee_id)}\n"
    end
    if setter_id_changed?
      comment += "* changed setter from #{User.find(setter_id_was)} to #{User.find(setter_id)}\n"
    end
    Comment.create!(issue: self, user: updater, comment: comment) unless comment.blank?
  end
end
