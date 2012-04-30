class HostingAccountsController < ApplicationController
  before_filter :admin_required
  before_filter :find_hosting_account, :except => [:index, :new, :create, :backups]

  def show
  end

  def new
    @hosting_account = HostingAccount.new
    @hosting_account.domain_id = params[:domain_id]
    @hosting_account.host_name = 'www.' + @hosting_account.domain.name
    @hosting_account.annual_fee = 90.00
  end

  def create
    @hosting_account = HostingAccount.new(params[:hosting_account])
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
    if @hosting_account.update_attributes(params[:hosting_account])
      flash[:notice] = 'Hosting account updated.'
      redirect_to hosting_account_path(@hosting_account)
    else
      render :action => 'edit'
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
end
