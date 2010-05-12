class AddressesController < ApplicationController
  before_filter :admin_required
  before_filter :find_address, :except => [:index, :new, :create]

  def new
    @address = Address.new
    @address.organisation_id = params[:organisation_id]
  end

  def create
    @address = Address.new(params[:address])
    if @address.save
      flash[:notice] = "Added new address."
      redirect_to organisation_path(@address.organisation)
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @address.update_attributes(params[:address])
      flash[:notice] = 'Address updated.'
      redirect_to organisation_path(@address.organisation)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @address.destroy
    flash[:notice] = "Address deleted."
    redirect_to organisation_path(@address.organisation)
  end

  private
  
  def find_address
    @address = Address.find_by_id(params[:id], :include => :organisation)
    if @address.nil?
      flash[:notice] = "That address doesn't exist."
      redirect_to addresses_path
    end
  end
end
