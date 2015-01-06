require 'rails_helper'

feature 'Tagging' do
  let(:client) { FactoryGirl.create(:organisation) }

  background do
    FactoryGirl.create(:admin)
    sign_in_as_admin
  end

  scenario 'No tags yet' do
    visit organisation_path(client)
    expect(page).to have_content 'No tags yet.'
  end

  scenario 'Add tag to organisation' do
    visit organisation_path(client)
    fill_in 'Tag', with: 'wordpress'
    click_button 'Add Tag'
    expect(page).to have_css('.tag-list', text: 'wordpress')
    expect(page).not_to have_content 'No tags yet.'
  end
end
