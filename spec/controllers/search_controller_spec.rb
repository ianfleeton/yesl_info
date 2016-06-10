require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  before { signed_in_as_admin }

  it { should route(:get, '/search').to(action: :index) }

  describe 'GET index' do
    it 'assigns @domains, @note_pads, @organisations, @timesheet_entries, @users' do
      pending 'remove assigns'
      get :index, query: 'q'
      expect(assigns(:domains)).to be
      expect(assigns(:note_pads)).to be
      expect(assigns(:organisations)).to be
      expect(assigns(:timesheet_entries)).to be
      expect(assigns(:users)).to be
    end
  end
end
