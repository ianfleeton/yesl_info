require 'rails_helper'

describe 'issues/_form' do
  before { assign(:issue, Issue.new) }

  context 'when admin' do
    before { view.stub(:admin?).and_return true }

    it 'renders a dropdown of organisations' do
      render
      expect(rendered).to have_selector('select#issue_organisation_id')
    end

    it 'renders a dropdown to select setter' do
      render
      expect(rendered).to have_selector('select#issue_setter_id')
    end

    it 'renders an input field for estimated time' do
      render
      expect(rendered).to have_selector('input#issue_estimated_time')
    end

    it 'renders a date select for date due' do
      render
      expect(rendered).to have_selector('select#issue_date_due_3i')
    end
  end

  context 'when user' do
    before { view.stub(:admin?).and_return false }

    it 'does not render a dropdown of organisations' do
      render
      expect(rendered).not_to have_selector('select#issue_organisation_id')      
    end

    it 'does not render a dropdown to select setter' do
      render
      expect(rendered).not_to have_selector('select#issue_setter_id')
    end

    it 'does not render an input field for estimated time' do
      render
      expect(rendered).not_to have_selector('input#issue_estimated_time')
    end

    it 'does not render a date select for date due' do
      render
      expect(rendered).not_to have_selector('select#issue_date_due_3i')
    end
  end
end
