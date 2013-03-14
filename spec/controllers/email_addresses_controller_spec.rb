require 'spec_helper'

describe EmailAddressesController do
  context 'when signed in as admin' do
    before { controller.stub(:admin?).and_return true }
  end

  context 'when not signed in as admin' do
    before { controller.stub(:admin?).and_return false }

    describe 'GET new' do
      it 'denies access' do
        get 'new'
        should_deny_access
      end
    end
  end

  def should_deny_access
    response.should redirect_to '/sessions/new'
  end
end
