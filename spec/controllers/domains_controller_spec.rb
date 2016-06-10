require 'rails_helper'

describe DomainsController do
  before { signed_in_as_admin }

  describe 'POST create' do
    it 'allows only whitelisted attributes to be set' do
      post 'create', { domain: Domain.new.attributes }
      expect(controller.send(:domain_params).keys).to eq(['forwarding_id', 'name', 'organisation_id', 'registered_on', 'with_us'])
    end

    context 'when the domain fails to save' do
      let(:domain) { double(Domain).as_null_object }

      before { allow(domain).to receive(:save).and_return(false) }

      it 'assigns @organisation' do
        pending 'remove assigns'
        allow(Domain).to receive(:new).and_return(domain)
        allow(domain).to receive(:organisation).and_return 'org'
        post 'create', { domain: { name: 'example.org' } }
        expect(assigns(:organisation)).to eq 'org'
      end
    end
  end

  def signed_in_as_admin
    allow(controller).to receive(:admin?).and_return(true)
  end
end
