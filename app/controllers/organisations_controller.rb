class OrganisationsController < ApplicationController
  before_filter :admin_required

  def index
    @organisations = Organisation.find(:all, :order => 'name')
  end
  
  def show
    @organisation = Organisation.find(params[:id])
    record_view
  end
  
  def new
    @organisation = Organisation.new
  end

  def create
    @organisation = Organisation.new(params[:organisation])
    @organisation.last_contacted = Time.now
    if @organisation.save
      flash[:notice] = "Successfully added new organisation."
      redirect_to :action => "show", :id => @organisation
    else
      render :action => "new"
    end
  end

  protected

  def record_view
    @organisation.last_viewed_at = Time.now
    @organisation.save
  end
end