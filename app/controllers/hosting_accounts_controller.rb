class HostingAccountsController < ApplicationController
  before_filter :admin_required, except: [:backups, :backed_up]
  before_filter :admin_or_token_required, only: [:backups, :backed_up]
  skip_before_filter :verify_authenticity_token, only: [:backed_up]

  before_filter :find_hosting_account, only: [:show, :edit, :update, :destroy, :backed_up]

  AUTH_TOKEN = 'pmcK3cXgXt'

  def show
  end

  def new
    @hosting_account = HostingAccount.new
    @hosting_account.domain_id = params[:domain_id]
    @hosting_account.host_name = 'www.' + @hosting_account.domain.name
    @hosting_account.annual_fee = 90.00
  end

  def create
    @hosting_account = HostingAccount.new(hosting_account_params)
    if @hosting_account.save
      flash[:notice] = "Added new hosting account."
      redirect_to hosting_account_path(@hosting_account)
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @hosting_account.update_attributes(hosting_account_params)
      redirect_to @hosting_account, notice: 'Hosting account updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @hosting_account.destroy
    flash[:notice] = "Hosting account deleted."
    redirect_to domain_path(@hosting_account.domain)
  end

  def backups
    @hosting_accounts = HostingAccount.all(
      conditions: ["backed_up_on < DATE_SUB(NOW(), INTERVAL backup_cycle DAY)"],
      order: "DATE_ADD(backed_up_on, INTERVAL backup_cycle DAY) asc",
      limit: 20)
    respond_to do |format|
      format.text do
      end
      format.html do
      end
    end
  end
  
  def backed_up
    @hosting_account.backed_up_on = Time.now
    @hosting_account.save!
    redirect_to :action => 'backups'
  end

  private
  
  def find_hosting_account
    @hosting_account = HostingAccount.find_by_id(params[:id], :include => :domain)
    if @hosting_account.nil?
      flash[:notice] = "That hosting account doesn't exist."
      redirect_to organisations_path
    end
  end

  def admin_or_token_required
    not_found and return unless (admin? || params[:auth_token] == AUTH_TOKEN)
  end

  def hosting_account_params
    params.require(:hosting_account).permit(:annual_fee, :backed_up_on, :backup_cycle, :domain_id, :ftp_host, :host_name, :password, :started_on, :username)
  end
end
