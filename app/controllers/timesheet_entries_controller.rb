class TimesheetEntriesController < ApplicationController
  before_action :admin_required
  before_action :find_timesheet_entry, only: [:edit, :update, :destroy]

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
      begin
        Slack::Webhook.trigger(:create, @timesheet_entry)
      rescue
        Rails.logger.warn "Slack webhook failed"
      end
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

  def report
  end

  def generate_report
    report = params[:report]
    start_date = Date.new report['start(1i)'].to_i, report['start(2i)'].to_i, report['start(3i)'].to_i
    end_date = Date.new report['end(1i)'].to_i, report['end(2i)'].to_i, report['end(3i)'].to_i

    @timesheet_entries = TimesheetEntry.where(organisation_id: report['organisation_id'],
      started_at: start_date.beginning_of_day..end_date.end_of_day)

    render 'report'
  end

  protected

  def find_timesheet_entry
    @timesheet_entry = TimesheetEntry.find(params[:id])
  end

  def timesheet_entry_params
    params.require(:timesheet_entry).permit(:chargeable, :description, :invoice_value, :minutes, :organisation_id, :started_at, :user_id)
  end
end
