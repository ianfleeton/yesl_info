class HostingAccount < ActiveRecord::Base
  belongs_to :domain, touch: true
end
