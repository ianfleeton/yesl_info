require 'rails_helper'

describe AddressesController do
  before { signed_in_as_admin }

  describe 'POST create' do
    it 'allows only address_line_1, address_line_2, county, organisation_id, postcode and town_city to be set' do
      post 'create', { address: Address.new.attributes }
      controller.send(:address_params).keys.should eq(['address_line_1', 'address_line_2', 'county', 'organisation_id', 'postcode', 'town_city'])
    end
  end

  def signed_in_as_admin
    controller.stub(:admin?).and_return(true)
  end
end
