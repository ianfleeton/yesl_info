class TimesheetEntriesController < ApplicationController
  before_filter :admin_required

  def index
    @staff = User.staff
    @timesheet_entries = TimesheetEntry.order('started_at DESC').limit(40)
  end
end
