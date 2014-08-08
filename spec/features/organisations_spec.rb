require 'rails_helper'

feature 'Organisations' do
  let(:admin) { FactoryGirl.create(:admin) }
  before { admin }

  scenario 'Watch an organisation' do
    sign_in_as_admin
    organisation = FactoryGirl.create(:organisation)
    visit organisation_path(organisation)
    click_link 'Watch'
    expect(organisation.watchers).to include admin
  end

  scenario 'Unwatch an organisation' do
    sign_in_as_admin
    organisation = FactoryGirl.create(:organisation)
    OrganisationWatcher.create!(organisation: organisation, watcher: admin)
    visit organisation_path(organisation)
    click_link 'Unwatch'
    expect(organisation.watchers).not_to include admin
  end
end
