require 'rails_helper'

describe HostingAccountsController do
  before { signed_in_as_admin }

  describe 'GET index' do
    it 'finds all hosting accounts' do
      expect(HostingAccount).to receive(:all)
      get :index
    end

    it 'renders JSON' do
      FactoryGirl.create(:hosting_account)
      get :index
      expect(response.body).to eq HostingAccount.all.to_json
    end
  end

  describe 'GET show' do
    it 'finds the hosting account' do
      expect(controller).to receive(:find_hosting_account)
      get 'show', params: { id: '1' }
    end
  end

  describe 'GET backups' do
    it 'succeeds' do
      get :backups
      expect(response).to be_successful
    end
  end

  def signed_in_as_admin
    allow(controller).to receive(:admin?).and_return(true)
  end
end
