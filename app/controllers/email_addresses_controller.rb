class EmailAddressesController < ApplicationController
  def new
    @email_address = EmailAddress.new
    @email_address.organisation_id = params[:organisation_id]
    @email_address.user_id = params[:user_id]
  end

  def create
    @email_address = EmailAddress.new(params[:email_address])
    if @email_address.save
      flash[:notice] = "Added new email address."
      if @email_address.user
        redirect_to @email_address.user
      else
        redirect_to @email_address.organisation
      end
    else
      render :action => "new"
    end
  end
end
