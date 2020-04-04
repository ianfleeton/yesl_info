require 'rails_helper'

feature 'Addresses' do
  let(:admin) { FactoryBot.create(:admin) }
  before { admin }

  scenario 'Edit address' do
    sign_in_as_admin
    organisation = FactoryBot.create(:organisation)
    address = FactoryBot.create(:address, organisation: organisation)
    visit organisation_path(organisation)
    click_link "Edit #{address}"
    new_street = SecureRandom.hex
    fill_in 'Address line 1', with: new_street
    click_button 'Update Address'
    address.reload
    expect(address.address_line_1).to eq new_street
  end
end
