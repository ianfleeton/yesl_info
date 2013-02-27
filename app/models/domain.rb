class Domain < ActiveRecord::Base
  belongs_to :organisation, touch: true
  belongs_to :forwarding, class_name: 'Domain'
  has_many :forwarding_from, class_name: 'Domain', foreign_key: 'forwarding_id', order: 'name', dependent: :nullify
  has_many :hosting_accounts, order: 'host_name'
end
