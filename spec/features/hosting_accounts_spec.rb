require 'rails_helper'

feature 'Hosting Accounts' do
  before { FactoryGirl.create(:admin) }

  scenario 'View hosting account via domain' do
    hosting_account = FactoryGirl.create(:hosting_account)
    sign_in_as_admin
    visit domain_path(hosting_account.domain)
    click_link 'www.example.org on'
  end
end
