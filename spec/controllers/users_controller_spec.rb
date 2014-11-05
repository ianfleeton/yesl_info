require 'rails_helper'
require 'errors'

describe UsersController do
  let(:organisation_id) { 123 }

  context 'when admin' do
    def user(stubs = {})
      @user ||= double(User, stubs).as_null_object
    end

    before { signed_in_as_admin }

    describe 'GET new' do
      it 'creates a new user' do
        expect(User).to receive(:new)
        get 'new'
      end

      it 'assigns @user' do
        allow(User).to receive(:new).and_return(user)
        get 'new'
        expect(assigns(:user)).to eq user
      end

      it "sets the new user's organisation" do
        get 'new', organisation_id: organisation_id
        expect(assigns(:user).organisation_id).to eq organisation_id
      end
    end
  end

  context 'when external user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe 'GET show' do
      it 'raises AuthorizationError when found user is different' do
        get :show, id: other_user.id
        expect(response).to redirect_to new_session_path
      end
    end
  end

  def signed_in_as_admin
    allow(controller).to receive(:admin?).and_return(true)
  end
end
