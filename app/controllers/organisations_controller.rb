class OrganisationsController < ApplicationController
  def index
    @organisations = Organisation.find(:all, :order => 'name')
  end
  
  def show
    @organisation = Organisation.find(params[:id])
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
end