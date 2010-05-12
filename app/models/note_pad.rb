class NotePad < ActiveRecord::Base
  validates_presence_of :organisation_id, :title, :content
  belongs_to :organisation
end
