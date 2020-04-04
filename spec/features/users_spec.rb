require 'rails_helper'

feature 'Users' do
  before { FactoryBot.create(:admin) }

  scenario 'Create new user' do
    organisation = FactoryBot.create(:organisation)
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
    org_a = FactoryBot.create(:organisation, name: 'A')
    org_b = FactoryBot.create(:organisation, name: 'B')
    client = FactoryBot.create(:user, organisation: org_a)
    sign_in_as_admin
    visit edit_user_path(client)
    select 'B', from: 'Organisation'
    click_button 'Save'
    client.reload
    expect(client.organisation).to eq org_b
    end
end
