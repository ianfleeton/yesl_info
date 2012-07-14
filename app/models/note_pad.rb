class NotePad < ActiveRecord::Base
  attr_accessible :organisation_id, :title, :content
  validates_presence_of :organisation_id, :title, :content
  belongs_to :organisation, touch: true
end
