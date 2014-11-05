require 'rails_helper'

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
    expect(page).to have_content 'Successfully added new user.'
  end

  scenario 'Reassign user to another organisation' do
    org_a = FactoryGirl.create(:organisation, name: 'A')
    org_b = FactoryGirl.create(:organisation, name: 'B')
    client = FactoryGirl.create(:user, organisation: org_a)
    sign_in_as_admin
    visit edit_user_path(client)
    select 'B', from: 'Organisation'
    click_button 'Save'
    client.reload
    expect(client.organisation).to eq org_b
    end
end
