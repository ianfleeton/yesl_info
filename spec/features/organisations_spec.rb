require 'rails_helper'

feature 'Organisations' do
  let(:admin) { FactoryGirl.create(:admin) }
  before { admin }

  scenario 'Archive an organisation' do
    sign_in_as_admin
    organisation = FactoryGirl.create(:organisation, archived: false)
    visit organisation_path(organisation)
    click_link 'Archive'
    expect(organisation.reload.archived?).to be_truthy
  end

  scenario 'Unarchive an organisation' do
    sign_in_as_admin
    organisation = FactoryGirl.create(:organisation, archived: true)
    visit organisation_path(organisation)
    click_link 'Unarchive'
    expect(organisation.reload.archived?).to be_falsey
  end
end
