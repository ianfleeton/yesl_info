require 'spec_helper'

feature 'Addresses' do
  let(:admin) { FactoryGirl.create(:admin) }
  before { admin }

  scenario 'Edit address' do
    sign_in_as_admin
    organisation = FactoryGirl.create(:organisation)
    address = FactoryGirl.create(:address, organisation: organisation)
    visit organisation_path(organisation)
    click_link "Edit #{address}"
    new_street = SecureRandom.hex
    fill_in 'Address line 1', with: new_street
    click_button 'Update Address'
    address.reload
    expect(address.address_line_1).to eq new_street
  end
end
