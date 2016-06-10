require 'rails_helper'
require 'errors'

RSpec.describe UsersController, type: :controller do
  let(:organisation) { FactoryGirl.create(:organisation) }
  let(:organisation_id) { 123 }

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      email: 'user@example.org',
      name: 'Jo',
      password: 'secret',
      organisation_id: organisation.id,
    }
  }

  let(:invalid_attributes) {
    {
      name: '',
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  context 'when admin' do
    def user(stubs = {})
      @user ||= double(User, stubs).as_null_object
    end

    before { signed_in_as_admin }

    describe 'GET index' do
      it "assigns all users as @users" do
        pending 'remove assigns'
        user = User.create! valid_attributes
        get :index, session: valid_session
        expect(assigns(:users)).to eq([user])
      end
    end

    describe 'GET new' do
      it 'creates a new user' do
        expect(User).to receive(:new)
        get 'new'
      end

      it 'assigns @user' do
        pending 'remove assigns'
        allow(User).to receive(:new).and_return(user)
        get 'new'
        expect(assigns(:user)).to eq user
      end

      it "sets the new user's organisation" do
        pending 'remove assigns'
        get 'new', params: { organisation_id: organisation_id }
        expect(assigns(:user).organisation_id).to eq organisation_id
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new User" do
          expect {
            post :create, params: {user: valid_attributes}, session: valid_session
          }.to change(User, :count).by(1)
        end

        it "assigns a newly created user as @user" do
          pending 'remove assigns'
          post :create, params: {user: valid_attributes}, session: valid_session
          expect(assigns(:user)).to be_a(User)
          expect(assigns(:user)).to be_persisted
        end

        it "redirects to the created user" do
          post :create, params: {user: valid_attributes}, session: valid_session
          expect(response).to redirect_to(User.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved user as @user" do
          pending 'remove assigns'
          post :create, params: {user: invalid_attributes}, session: valid_session
          expect(assigns(:user)).to be_a_new(User)
        end

        it "re-renders the 'new' template" do
          pending 'remove assert_template'
          post :create, params: {user: invalid_attributes}, session: valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {
            email: 'updated@example.org'
          }
        }

        it "updates the requested user" do
          user = User.create! valid_attributes
          put :update, params: {id: user.to_param, user: new_attributes}, session: valid_session
          user.reload
          expect(user.email).to eq new_attributes[:email]
        end

        it "assigns the requested user as @user" do
          pending 'remove assigns'
          user = User.create! valid_attributes
          put :update, params: {id: user.to_param, user: valid_attributes}, session: valid_session
          expect(assigns(:user)).to eq(user)
        end

        it "redirects to the user" do
          user = User.create! valid_attributes
          put :update, params: {id: user.to_param, user: valid_attributes}, session: valid_session
          expect(response).to redirect_to(user)
        end
      end

      context "with invalid params" do
        it "assigns the user as @user" do
          pending 'remove assigns'
          user = User.create! valid_attributes
          put :update, params: {id: user.to_param, user: invalid_attributes}, session: valid_session
          expect(assigns(:user)).to eq(user)
        end

        it "re-renders the 'edit' template" do
          pending 'remove assert_template'
          user = User.create! valid_attributes
          put :update, params: {id: user.to_param, user: invalid_attributes}, session: valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested user" do
        user = User.create! valid_attributes
        expect {
          delete :destroy, params: {id: user.to_param}, session: valid_session
        }.to change(User, :count).by(-1)
      end

      it "redirects to the users list" do
        user = User.create! valid_attributes
        delete :destroy, params: {id: user.to_param}, session: valid_session
        expect(response).to redirect_to(users_url)
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
        get :show, params: { id: other_user.id }
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe 'POST forgot_password_send' do
    let!(:user) { FactoryGirl.create(:user, forgot_password_token: 'unchanged') }

    context 'when user found by email' do
      let(:email) { user.email }
      it "updates the user's forgot_password_token" do
        allow_any_instance_of(ActionMailer::MessageDelivery).to receive(:deliver_now)
        post :forgot_password_send, params: { email: email }
        expect(user.reload.forgot_password_token).not_to eq 'unchanged'
      end
    end

    context 'when user not found' do
      let(:email) { 'nonexistent' }
      it 'redirects to forgot_password' do
        post :forgot_password_send, params: { email: email }
        expect(response).to redirect_to(action: :forgot_password)
      end
    end
  end

  def signed_in_as_admin
    allow(controller).to receive(:admin?).and_return(true)
  end
end
