class TimesheetEntriesController < ApplicationController
  before_filter :admin_required
  before_filter :find_timesheet_entry, only: [:edit, :update, :destroy]

  def index
    @staff = User.staff
    @timesheet_entries = TimesheetEntry.order('started_at DESC').limit(40)
  end

  def new
    @timesheet_entry = TimesheetEntry.new(user_id: @current_user.id)
  end

  def create
    @timesheet_entry = TimesheetEntry.new(params[:timesheet_entry])
    if @timesheet_entry.save
      flash[:notice] = "Successfully added new timesheet entry."
      redirect_to @timesheet_entry.organisation
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @timesheet_entry.update_attributes(params[:timesheet_entry])
      redirect_to @timesheet_entry.organisation, notice: 'Timesheet entry updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @timesheet_entry.destroy
    redirect_to @timesheet_entry.organisation, notice: 'Timesheet entry deleted.'
  end

  protected

  def find_timesheet_entry
    @timesheet_entry = TimesheetEntry.find(params[:id])
  end
end
