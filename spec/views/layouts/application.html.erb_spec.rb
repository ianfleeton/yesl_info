require 'rails_helper'

RSpec.describe 'layouts/application.html.erb', type: :view do
  let(:logged_in?) { true }
  let(:current_user) { User.new }
  before do
    allow(view).to receive(:logged_in?).and_return(logged_in?)
    assign(:current_user, current_user)
  end

  context 'as admin' do
    before { allow(view).to receive(:admin?).and_return(true) }

    it 'renders the search template' do
      pending 'remove assert_template'
      render
      expect(response).to render_template 'application/_search'
    end
  end
end
