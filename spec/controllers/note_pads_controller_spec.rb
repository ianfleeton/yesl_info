require 'rails_helper'

RSpec.describe NotePadsController, type: :controller do
  before { signed_in_as_admin }

  describe 'POST create' do
    it 'creates a new notepad' do
      params = {title: 'my title', organisation_id: FactoryGirl.create(:organisation).id, content: 'my content'}
      post :create, params: { note_pad: params }

      expect(NotePad.find_by(params)).to be
    end
  end

end
