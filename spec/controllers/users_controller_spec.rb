require 'spec_helper'

describe UsersController do
  before { signed_in_as_admin }
  let(:organisation_id) { 123 }

  def user(stubs = {})
    @user ||= mock_model(User, stubs).as_null_object
  end

  describe 'GET new' do
    it 'creates a new user' do
      User.should_receive(:new)
      get 'new'
    end

    it 'assigns @user' do
      User.stub(:new).and_return(user)
      get 'new'
      assigns(:user).should eq user
    end

    it "sets the new user's organisation" do
      get 'new', organisation_id: organisation_id
      assigns(:user).organisation_id.should eq organisation_id
    end
  end

  def signed_in_as_admin
    controller.stub(:admin?).and_return(true)
  end
end
