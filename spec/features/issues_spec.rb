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
    select 'major', from: 'Priority'
    click_button 'Create Issue'
    expect(page).to have_content 'Issue saved.'
    expect(page).to have_content 'Make coffee'
    expect(page).to have_selector '.priority-major'
  end

  scenario 'Resolve issue', js: true do
    issue = FactoryGirl.create(:issue)
    sign_in_as_admin
    visit issue_path(issue)
    click_link 'Resolve'
    fill_in 'resolve-comment', with: 'Fixed'
    click_button 'resolve-submit'
    expect(page).to have_content('changed status to resolved')
    expect(page).to have_content('Fixed')
    issue.reload
    expect(issue.completed).to be_true
  end

  scenario 'Reopen issue', js: true do
    issue = FactoryGirl.create(:issue, completed: true)
    sign_in_as_admin
    visit issue_path(issue)
    click_link 'Reopen'
    fill_in 'reopen-comment', with: 'Not fixed yet'
    click_button 'reopen-submit'
    expect(page).to have_content('reopened the issue')
    expect(page).to have_content('Not fixed yet')
    issue.reload
    expect(issue.completed).to be_false
  end
end
