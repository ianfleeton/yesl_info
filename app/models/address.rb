class Address < ActiveRecord::Base
  belongs_to :organisation, touch: true

  validates_presence_of :address_line_1
  validates_presence_of :organisation

  def to_s
    "#{address_line_1}, #{postcode}"
  end
end
