class OrganisationsController < ApplicationController
  before_filter :admin_required
  before_filter :find_organisation, only: [:show, :edit, :update, :destroy, :contacted]

  def index
    @organisations = Organisation.order('name')
  end
  
  def show
    record_view
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
      .limit(10)
  end

  def contacted
    @organisation.touch(:last_contacted)
    redirect_to @organisation, notice: 'Contact recorded.'
  end

  protected

  def find_organisation
    @organisation = Organisation.find(params[:id])
  end

  def record_view
    @organisation.last_viewed_at = Time.now
    @organisation.save
  end

  def organisation_params
    params.require(:organisation).permit(:contact_cycle, :name, :on_stop)
  end
end
