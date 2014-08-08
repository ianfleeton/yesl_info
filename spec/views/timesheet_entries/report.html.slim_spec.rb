require 'rails_helper'

describe 'timesheet_entries/report' do
  it 'displays a heading' do
    render
    expect(rendered).to have_content(t('timesheet_entries.report.heading'))
  end
end
