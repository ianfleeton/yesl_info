require 'rails_helper'

feature 'Timesheet Report' do
  before { FactoryBot.create(:admin) }

  scenario 'Reach report page from timesheet page' do
    sign_in_as_admin

    visit timesheet_entries_path

    click_link 'Report'

    expect(current_path).to eq report_timesheet_entries_path
  end

  scenario 'Prepare a report with a date range' do
    sign_in_as_admin

    bodge_it = FactoryBot.create(:organisation, name: 'Bodge IT')
    scarper = FactoryBot.create(:organisation, name: 'Scarper')

    job_1 = FactoryBot.create(:timesheet_entry, organisation: bodge_it, description: 'Wrote code', started_at: '2012-08-13 00:00:00', invoice_value: 5.0, chargeable: true)
    job_2 = FactoryBot.create(:timesheet_entry, organisation: scarper, description: 'Designed', started_at: '2012-08-13 00:00:00', invoice_value: 19.0, chargeable: true)
    job_3 = FactoryBot.create(:timesheet_entry, organisation: bodge_it, description: 'Deployed', started_at: '2013-06-29 23:59:59', invoice_value: 7.0, chargeable: true)
    job_4 = FactoryBot.create(:timesheet_entry, organisation: bodge_it, description: 'Tested', started_at: '2013-06-30 00:00:00', invoice_value: 11.0, chargeable: true)

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
