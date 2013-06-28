class DomainsController < ApplicationController
  before_action :admin_required
  before_action :find_domain, except: [:index, :new, :create]

  def index
    @domains = Domain.order('name')
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
    @domain = Domain.new(domain_params)
    if @domain.save
      flash[:notice] = "Added new domain."
      redirect_to domain_path(@domain)
    else
      @organisation = @domain.organisation
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @domain.update_attributes(domain_params)
      redirect_to @domain, notice: 'Domain updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @domain.destroy
    redirect_to @domain.organisation, notice: 'Domain deleted.'
  end

  def renewals
    
  end

  private
  
  def find_domain
    @domain = Domain.includes(:organisation).find_by(id: params[:id])
    if @domain.nil?
      redirect_to domains_path, notice: "That domain doesn't exist."
    end
  end

  def domain_params
    params.require(:domain).permit(:forwarding_id, :name, :organisation_id, :registered_on, :with_us)
  end
end
