class TimesheetEntriesController < ApplicationController
  def index
    @staff = User.staff
    @timesheet_entries = TimesheetEntry.all(:order => 'started_at DESC', :limit => 40)
  end
end
