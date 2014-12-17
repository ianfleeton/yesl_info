require 'rails_helper'

describe 'issues/calendar.html.slim' do
  let(:issue) { FactoryGirl.create(:issue) }

  context 'with issues' do
    before do
      assign(:issues, [issue])
    end

    it 'renders issues' do
      render
      expect(rendered).to have_selector('p', text: issue.title)
    end
  end
end
