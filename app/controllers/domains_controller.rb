class DomainsController < ApplicationController
  before_filter :admin_required
  before_filter :find_domain, :except => [:index, :new, :create]

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

  def create
    @domain = Domain.new(params[:domain])
    if @domain.save
      flash[:notice] = "Added new domain."
      redirect_to domain_path(@domain)
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @domain.update_attributes(params[:domain])
      flash[:notice] = 'Domain updated.'
      redirect_to domain_path(@domain)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @domain.destroy
    flash[:notice] = "Domain deleted."
    redirect_to organisation_path(@domain.organisation)
  end

  private
  
  def find_domain
    @domain = Domain.find_by_id(params[:id], :include => :organisation)
    if @domain.nil?
      flash[:notice] = "That domain doesn't exist."
      redirect_to domains_path
    end
  end
end