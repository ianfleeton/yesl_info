class Comment < ActiveRecord::Base
  belongs_to :issue, touch: true
  belongs_to :user, touch: true

  validates :comment, presence: true
  validates :issue_id, presence: true

  after_create :notify_watchers

  delegate :watchers, to: :issue

  def notify_watchers
    watchers.each do |watcher|
      IssueNotifier.new_comment(self, watcher).deliver_now
    end
  end
end
