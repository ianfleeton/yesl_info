require 'spec_helper'

describe DomainsController do
  before { signed_in_as_admin }

  describe 'POST create' do
    it 'allows only whitelisted attributes to be set' do
      post 'create', { domain: Domain.new.attributes }
      controller.send(:domain_params).keys.should eq(['forwarding_id', 'name', 'organisation_id', 'registered_on', 'with_us'])
    end

    context 'when the domain fails to save' do
      let(:domain) { mock_model(Domain).as_null_object }

      before { domain.stub(:save).and_return(false) }

      it 'assigns @organisation' do
        Domain.stub(:new).and_return(domain)
        domain.stub(:organisation).and_return 'org'
        post 'create', { domain: { name: 'example.org' } }
        assigns(:organisation).should == 'org'
      end
    end
  end

  def signed_in_as_admin
    controller.stub(:admin?).and_return(true)
  end
end
