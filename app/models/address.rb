class Address < ActiveRecord::Base
  attr_accessible :organisation_id, :address_line_1, :address_line_2, :town_city, :county, :postcode
  belongs_to :organisation, touch: true
end
