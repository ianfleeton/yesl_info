class EmailAddressesController < ApplicationController
  before_action :admin_required
  before_action :find_email_address, only: [:edit, :update, :destroy]

  def new
    @email_address = EmailAddress.new
    @email_address.organisation_id = params[:organisation_id]
    @email_address.user_id = params[:user_id]
  end

  def create
    @email_address = EmailAddress.new(email_address_params)
    if @email_address.save
      flash[:notice] = 'Added new email address.'
      if @email_address.user
        redirect_to @email_address.user
      else
        redirect_to @email_address.organisation
      end
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @email_address.update_attributes(email_address_params)
      flash[:notice] = 'Email address updated.'
      redirect_to(@email_address.organisation ? @email_address.organisation : @email_address.user)
    else
      render action: 'edit'
    end
  end

  def destroy
    @email_address.destroy
    flash[:notice] = 'Email address deleted.'
    redirect_to(@email_address.organisation ? @email_address.organisation : @email_address.user)
  end

  protected

  def find_email_address
    @email_address = EmailAddress.find(params[:id])
  end

  def email_address_params
    params.require(:email_address).permit(:address, :organisation_id, :password, :user_id)
  end
end
