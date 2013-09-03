class Domain < ActiveRecord::Base
  belongs_to :organisation, touch: true
  belongs_to :forwarding, class_name: 'Domain'
  has_many :forwarding_from, -> { order 'name' }, class_name: 'Domain', foreign_key: 'forwarding_id', dependent: :nullify
  has_many :hosting_accounts, -> { order 'host_name' }, dependent: :delete_all

  validates_presence_of :name
  validates_presence_of :organisation
end
