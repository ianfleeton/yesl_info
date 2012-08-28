class Domain < ActiveRecord::Base
  attr_accessible :forwarding_id, :name, :organisation_id, :registered_on, :with_us

  belongs_to :organisation, touch: true
  belongs_to :forwarding, class_name: 'Domain'
  has_many :forwarding_from, class_name: 'Domain', foreign_key: 'forwarding_id', order: 'name', dependent: :nullify
  has_many :hosting_accounts, order: 'host_name'
end
