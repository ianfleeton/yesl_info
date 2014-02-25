class OrganisationWatcher < ActiveRecord::Base
  belongs_to :organisation, touch: true
  belongs_to :watcher, class_name: 'User', foreign_key: 'user_id'

  validates :user_id, uniqueness: { scope: :organisation_id }
end
