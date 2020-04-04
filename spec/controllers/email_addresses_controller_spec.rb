require 'rails_helper'

RSpec.describe EmailAddressesController, type: :controller do
  it { should use_before_action :admin_required }

  before { allow(controller).to receive(:admin?).and_return(true) }

  let(:user) { FactoryBot.create(:user) }

  # This should return the minimal set of attributes required to create a valid
  # EmailAddress. As you add validations to EmailAddress, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      address: 'An address',
      user_id: user.id
    }
  }

  let(:invalid_attributes) {
    {
      user_id: '1'
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EmailAddressesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET new' do
    let(:organisation_id) { 1 }
    let(:user_id) { 2 }
    before { get :new, params: { organisation_id: organisation_id, user_id: user_id } }

    it 'assigns a new EmailAddress to @email_address' do
      pending 'remove assigns'
      expect(assigns(:email_address)).to be_instance_of(EmailAddress)
      expect(assigns(:email_address).new_record?).to be_truthy
    end

    it 'sets the email address organisation_id and user_id to match params' do
      pending 'remove assigns'
      expect(assigns(:email_address).organisation_id).to eq organisation_id
      expect(assigns(:email_address).user_id).to eq user_id
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new EmailAddress" do
        expect {
          post :create, params: {email_address: valid_attributes}, session: valid_session
        }.to change(EmailAddress, :count).by(1)
      end

      it "assigns a newly created email_address as @email_address" do
        pending 'remove assigns'
        post :create, params: {email_address: valid_attributes}, session: valid_session
        expect(assigns(:email_address)).to be_a(EmailAddress)
        expect(assigns(:email_address)).to be_persisted
      end

      it "redirects to the created email address's owner" do
        post :create, params: {email_address: valid_attributes}, session: valid_session
        expect(response).to redirect_to(user)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved email_address as @email_address" do
        pending 'remove assigns'
        post :create, params: {email_address: invalid_attributes}, session: valid_session
        expect(assigns(:email_address)).to be_a_new(EmailAddress)
      end

      it "re-renders the 'new' template" do
        pending 'remove assert_template'
        post :create, params: {email_address: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end
end
