class HostingAccount < ActiveRecord::Base
  validates_numericality_of :port, greater_than: 0, less_than: 65536, only_integer: true
  validates_inclusion_of :scheme, in: %w{http https}

  belongs_to :domain, touch: true

  def url
    "#{scheme}://#{host_name}" + (port == 80 ? '' : ":#{port}")
  end
end
