class NumbersController < ApplicationController
  before_filter :admin_required
  before_filter :find_number, only: [:edit, :update, :destroy]

  def new
    @number = Number.new
    @number.organisation_id = params[:organisation_id]
    @number.user_id = params[:user_id]
  end

  def create
    @number = Number.new(number_params)
    if @number.save
      flash[:notice] = 'Added new number.'
      if @number.user
        redirect_to @number.user
      else
        redirect_to @number.organisation
      end
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @number.update_attributes(number_params)
      flash[:notice] = 'Number updated.'
      redirect_to(@number.organisation ? @number.organisation : @number.user)
    else
      render action: 'edit'
    end
  end

  def destroy
    @number.destroy
    flash[:notice] = 'Number deleted.'
    redirect_to(@number.organisation ? @number.organisation : @number.user)
  end

  protected

  def find_number
    @number = Number.find(params[:id])
  end

  def number_params
    params.require(:number).permit(:number, :organisation_id, :teltype, :user_id)
  end
end
