require 'spec_helper'

describe HostingAccountsController do
  before { signed_in_as_admin }

  describe 'GET show' do
    it 'finds the hosting account' do
      controller.should_receive(:find_hosting_account)
      get 'show', id: '1'
    end
  end

  def signed_in_as_admin
    controller.stub(:admin?).and_return(true)
  end
end
