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

  scenario 'Find organisations with same tag' do
    client.tag_list << 'worldpay'
    client.save

    client2 = FactoryGirl.create(:organisation)
    client2.tag_list << 'worldpay'
    client2.save

    visit organisation_path(client)
    click_link 'worldpay'

    expect(page).to have_content 'Organisations tagged with "worldpay"'

    within '.result-list' do
      click_link client2.name
    end

    expect(page).to have_css('h1', text: client2.name)
  end

  scenario 'Remove tag from organisation' do
    client.tag_list << 'worldpay'
    client.save

    visit organisation_path(client)
    click_button 'Remove worldpay tag'

    expect(page).not_to have_css('.tag-list', text: 'worldpay')
  end
end
