class DomainsController < ApplicationController
  before_filter :admin_required
  before_filter :find_domain, :only => [:show, :destroy]
  
  def index
    @domains = Domain.all :order => :name
  end
  
  def show
  end
  
  def new
    @domain = Domain.new
    begin
      org = Organisation.find(params[:organisation_id])
      @domain.organisation_id = params[:organisation_id]
    rescue
      flash[:notice] = 'No organisation. Chaos!'
      redirect_to domains_path
    end
  end
  
  def destroy
    @domain.destroy
    flash[:notice] = "Domain deleted."
    redirect_to organisation_path(@domain.organisation)
  end

  private
  
  def find_domain
    @domain = Domain.find(params[:id], :include => :organisation)
  end
end