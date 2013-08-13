require 'spec_helper'

feature 'Timesheet Report' do
  before { FactoryGirl.create(:admin) }

  scenario 'Reach report page from timesheet page' do
    sign_in_as_admin

    visit timesheet_entries_path

    click_link 'Report'

    expect(current_path).to eq report_timesheet_entries_path
  end

  scenario 'Prepare a report with a date range' do
    sign_in_as_admin

    bodge_it = FactoryGirl.create(:organisation, name: 'Bodge IT')
    scarper = FactoryGirl.create(:organisation, name: 'Scarper')

    job_1 = FactoryGirl.create(:timesheet_entry, organisation: bodge_it, description: 'Wrote code', started_at: '2012-08-13 00:00:00', invoice_value: 5.0)
    job_2 = FactoryGirl.create(:timesheet_entry, organisation: scarper, description: 'Designed', started_at: '2012-08-13 00:00:00', invoice_value: 19.0)
    job_3 = FactoryGirl.create(:timesheet_entry, organisation: bodge_it, description: 'Deployed', started_at: '2013-06-29 23:59:59', invoice_value: 7.0)
    job_4 = FactoryGirl.create(:timesheet_entry, organisation: bodge_it, description: 'Tested', started_at: '2013-06-30 00:00:00', invoice_value: 11.0)

    visit report_timesheet_entries_path

    select 'Bodge IT', from: 'report_organisation_id'

    select '2012', from: 'report_start_1i'
    select 'August', from: 'report_start_2i'
    select '13', from: 'report_start_3i'

    select '2013', from: 'report_end_1i'
    select 'June', from: 'report_end_2i'
    select '29', from: 'report_end_3i'

    click_button 'Generate Report'

    expect(page).to have_content 'Wrote code'
    expect(page).to have_content 'Deployed'
    expect(page).not_to have_content 'Tested'
    expect(page).not_to have_content 'Designed'
    expect(page).to have_content 'Total invoiced: £12.00'
  end
end
