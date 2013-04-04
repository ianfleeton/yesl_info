class TimesheetEntriesController < ApplicationController
  before_filter :admin_required
  before_filter :find_timesheet_entry, only: [:edit, :update, :destroy]

  def index
    @staff = User.staff
    entries(0)
  end

  def more_timesheet_entries
    entries(params[:offset].to_i)
    render layout: nil
  end

  def entries(offset)
    @timesheet_entries = TimesheetEntry.includes(:organisation, :user).order('started_at DESC').limit(200).offset(offset)
    @offset = offset + 200
  end

  def new
    @timesheet_entry = TimesheetEntry.new(user_id: @current_user.id)
  end

  def create
    @timesheet_entry = TimesheetEntry.new(timesheet_entry_params)
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
    if @timesheet_entry.update_attributes(timesheet_entry_params)
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

  def timesheet_entry_params
    params.require(:timesheet_entry).permit(:chargeable, :description, :invoice_value, :minutes, :organisation_id, :started_at, :user_id)
  end
end
