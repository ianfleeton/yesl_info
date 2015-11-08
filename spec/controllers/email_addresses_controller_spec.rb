require 'rails_helper'

RSpec.describe EmailAddressesController, type: :controller do
  it { should use_before_action :admin_required }

  before { allow(controller).to receive(:admin?).and_return(true) }

  describe 'GET new' do
    let(:organisation_id) { 1 }
    let(:user_id) { 2 }
    before { get :new, organisation_id: organisation_id, user_id: user_id }

    it 'assigns a new EmailAddress to @email_address' do
      expect(assigns(:email_address)).to be_instance_of(EmailAddress)
      expect(assigns(:email_address).new_record?).to be_truthy
    end

    it 'sets the email address organisation_id and user_id to match params' do
      expect(assigns(:email_address).organisation_id).to eq organisation_id
      expect(assigns(:email_address).user_id).to eq user_id
    end
  end
end
