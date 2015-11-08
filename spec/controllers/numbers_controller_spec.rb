require 'rails_helper'

RSpec.describe NumbersController, type: :controller do
  before { signed_in_as_admin }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # NumbersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #new" do
    it "assigns a new number as @number" do
      get :new, {}, valid_session
      expect(assigns(:number)).to be_a_new(Number)
    end

    it 'assigns the organisation_id and user_id params to the number' do
      get :new, { organisation_id: 1, user_id: 2 }, valid_session
      expect(assigns(:number).organisation_id).to eq 1
      expect(assigns(:number).user_id).to eq 2
    end
  end

  describe 'POST create' do
    it 'allows only number, organisation_id and teltype to be set' do
      post 'create', { number: Number.new.attributes }
      expect(controller.send(:number_params).keys).to eq(['number', 'organisation_id', 'teltype', 'user_id'])
    end
  end

  def signed_in_as_admin
    allow(controller).to receive(:admin?).and_return(true)
  end
end
