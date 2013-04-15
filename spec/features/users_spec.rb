require 'spec_helper'

feature 'Users' do
  before { FactoryGirl.create(:admin) }

  scenario 'Create new user' do
    organisation = FactoryGirl.create(:organisation)
    sign_in_as_admin
    visit organisation_path(organisation)
    click_link 'Add User'
    fill_in 'Name', with: 'Alice Adams'
    fill_in 'Email', with: 'alice.adams@example.org'
    fill_in 'Password', with: 'secret'
    click_button 'Save'
    page.should have_content 'Successfully added new user.'
  end
end
