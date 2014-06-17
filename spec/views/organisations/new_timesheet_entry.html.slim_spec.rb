require 'spec_helper'

describe 'organisations/new_timesheet_entry.html.slim' do
  let(:timesheet_entry) { TimesheetEntry.new }

  before do
    assign(:organisation, Organisation.new)
    assign(:timesheet_entry, timesheet_entry)
  end

  it 'renders' do
    render
  end
end
