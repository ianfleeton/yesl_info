class UsersController < ApplicationController
  before_filter :find_user, :except => [:index, :new, :create, :forgot_password, :forgot_password_send]
  before_filter :admin_required, :only => [:index, :new, :create, :destroy]

  def index
    @users = User.find(:all, :order => "name", :include => :organisation)
  end
  
  def show
    @offset = 100
  end

  def new
    @user = User.new(organisation_id: params[:organisation_id])
  end
  
  def create
    @user = User.new(admin? ? user_params_for_admin : user_params)
    
    if @user.save
      redirect_to @user, notice: 'Successfully added new user.'
    else
      render :action => "new"
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(admin? ? user_params_for_admin : user_params)
      flash[:notice] = "User successfully updated."
      redirect_to :action => "show", :id => @user.id
    else
      render :action => "edit"
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "User successfully destroyed."
    redirect_to :action => "index"
  end

  def forgot_password
  end
  
  def forgot_password_send
    @user = User.find_by_email(params[:email])
    if @user.nil? || @user.email.blank?
      flash[:notice] = "There is no user registered with that email address"
      redirect_to action: 'forgot_password'
    else
      @user.forgot_password_token = User.generate_forgot_password_token
      @user.save
      UserNotifier.token(@user).deliver
    end
  end

  def forgot_password_new
    forgot_password_params_ok?
  end
  
  def forgot_password_change
    if forgot_password_params_ok?
      @user.password = params[:password]
      @user.forgot_password_token = ''
      @user.save
      flash[:notice] = 'Your password has been changed'
      redirect_to :controller => 'sessions', :action => 'new'
    end
  end

  def more_timesheet_entries
    offset = params[:offset].to_i
    @timesheet_entries = @user.timesheet_entries.order('started_at DESC').limit(200).offset(offset)
    @offset = offset + 200
    render 'timesheet_entries/more_timesheet_entries', layout: nil
  end

  private
  
  def forgot_password_params_ok?
    if @user.forgot_password_token.blank?
      flash[:notice] = "Please enter your email address below"
      redirect_to :action => "forgot_password"
      return false
    elsif params[:t].nil? or @user.forgot_password_token != params[:t]
      flash[:notice] = "The link you entered was invalid. This can happen if you have re-requested " +
        "a forgot password email or you have already reset and changed your password."
      redirect_to :action => "forgot_password"
      return false
    end
    true
  end
  
  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :password)
  end

  def user_params_for_admin
    params.require(:user).permit(:admin, :email, :name, :organisation_id, :password, :staff)
  end
end
