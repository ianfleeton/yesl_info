require 'rails_helper'
require_relative 'show_shared'

describe 'organisations/show_admin.html.slim' do
  let(:organisation) { FactoryGirl.create(:organisation) }

  before do
    view.stub(:current_user).and_return(FactoryGirl.create(:admin))
    assign(:organisation, organisation)
  end

  it_behaves_like 'a show organisation page'

  it 'links to a new timesheet entry form' do
    render
    expect(rendered).to have_selector "a[href='#{new_timesheet_entry_organisation_path(organisation)}']"
  end
end
