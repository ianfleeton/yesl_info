class Address < ActiveRecord::Base
  belongs_to :organisation, touch: true
end
