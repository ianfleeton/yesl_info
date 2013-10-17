require 'spec_helper'

feature 'Issues' do
  before do
    @organisation = FactoryGirl.create(:organisation)
    FactoryGirl.create(:admin)
  end

  scenario 'New issue from organisation page' do
    sign_in_as_admin
    visit organisation_path(@organisation)
    click_link 'Add Issue'
    fill_in 'Title', with: 'Make coffee'
    fill_in 'Details', with: 'Add cream'
    fill_in 'Estimated time', with: '10'
    select '3', from: 'Priority'
    click_button 'Create Issue'
    page.should have_content 'Issue saved.'
    page.should have_content 'Make coffee'
    page.should have_content 'Add cream'
    page.should have_content '10m'
    page.should have_content '3'
  end
end
