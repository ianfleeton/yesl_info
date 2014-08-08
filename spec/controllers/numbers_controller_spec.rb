require 'rails_helper'

describe NumbersController do
  before { signed_in_as_admin }

  describe 'POST create' do
    it 'allows only number, organisation_id and teltype to be set' do
      post 'create', { number: Number.new.attributes }
      controller.send(:number_params).keys.should eq(['number', 'organisation_id', 'teltype', 'user_id'])
    end
  end

  def signed_in_as_admin
    controller.stub(:admin?).and_return(true)
  end
end
