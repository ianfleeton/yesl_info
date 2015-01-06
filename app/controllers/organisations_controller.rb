class OrganisationsController < ApplicationController
  before_action :admin_required, except: [:show]
  before_action :user_required, only: [:show]

  before_action :find_organisation, only: [
    :add_tag,
    :archive,
    :contacted,
    :destroy,
    :edit,
    :more_timesheet_entries,
    :new_timesheet_entry,
    :remove_tag,
    :show,
    :unarchive,
    :unwatch,
    :update,
    :watch
  ]

  def index
    archived = params[:archived] == '1'
    @organisations = Organisation.order('name').where(archived: archived)
  end
  
  def show
    record_view
    @offset = 100

    if admin?
      render 'show_admin'
    else
      redirect_to new_session_path and return unless same_organisation_as? @organisation
    end
  end
  
  def new
    @organisation = Organisation.new
  end

  def create
    @organisation = Organisation.new(organisation_params)
    @organisation.last_contacted = Time.now
    if @organisation.save
      flash[:notice] = "Successfully added new organisation."
      redirect_to :action => "show", :id => @organisation
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @organisation.update_attributes(organisation_params)
      redirect_to @organisation, notice: 'Organisation updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @organisation.destroy
    redirect_to organisations_path, notice: "#{@organisation.name} deleted."
  end

  def contacts
    @organisations = Organisation
      .where('last_contacted < DATE_SUB(NOW(), INTERVAL contact_cycle DAY)')
      .order('DATE_ADD(last_contacted, INTERVAL contact_cycle DAY) ASC')
      .limit(20)
  end

  def contacted
    @organisation.touch(:last_contacted)
    redirect_to @organisation, notice: 'Contact recorded.'
  end

  def new_timesheet_entry
    @timesheet_entry = TimesheetEntry.new(organisation_id: @organisation.id, user_id: current_user.id)
  end

  def more_timesheet_entries
    offset = params[:offset].to_i
    @timesheet_entries = @organisation.timesheet_entries.order('started_at DESC').limit(200).offset(offset)
    @offset = offset + 200
    render 'timesheet_entries/more_timesheet_entries', layout: nil
  end

  def unwatch
    OrganisationWatcher.where(organisation: @organisation, watcher: current_user).delete_all
    redirect_to @organisation
  end

  def watch
    OrganisationWatcher.create(organisation: @organisation, watcher: current_user)
    redirect_to @organisation
  end

  def archive
    @organisation.archived = true
    @organisation.save
    redirect_to @organisation
  end

  def unarchive
    @organisation.archived = false
    @organisation.save
    redirect_to @organisation
  end

  def add_tag
    @organisation.tag_list << params[:tag]
    @organisation.save
    @organisation.touch
    redirect_to @organisation, notice: 'Tagged.'
  end

  def remove_tag
    @organisation.tag_list.remove(params[:tag])
    @organisation.save
    @organisation.touch
    redirect_to @organisation, notice: 'Tag removed.'
  end

  def tagged_with
    @organisations = Organisation.tagged_with params[:tag]
    @tag = params[:tag]
  end

  protected

  def find_organisation
    @organisation = Organisation.find(params[:id])
  end

  def record_view
    @organisation.update_column(:last_viewed_at, Time.now)
  end

  def organisation_params
    params.require(:organisation).permit(:contact_cycle, :name, :on_stop)
  end
end
