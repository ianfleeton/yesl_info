require 'spec_helper'

feature 'To-Dos' do
  before do
    @organisation = FactoryGirl.create(:organisation)
    FactoryGirl.create(:admin)
  end

  scenario 'New to-do from organisation page' do
    sign_in_as_admin
    visit organisation_path(@organisation)
    click_link 'Add ToDo'
    fill_in 'Title', with: 'Make coffee'
    fill_in 'Details', with: 'Add cream'
    fill_in 'Estimated time', with: '10'
    select '3', from: 'Priority'
    click_button 'Create To do'
    page.should have_content 'To-do saved.'
    page.should have_content 'Make coffee'
    page.should have_content 'Add cream'
    page.should have_content '10m'
    page.should have_content '3'
  end

  def sign_in_as_admin
    visit '/sessions/new'
    fill_in 'Email', with: 'admin@example.org'
    fill_in 'Password', with: 'secret'
    click_button 'Login'
  end
end
