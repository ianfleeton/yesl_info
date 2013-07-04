class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  before_action :set_timezone, :ssl_required, :initialize_user
  
  # make these available as ActionView helper methods.
  helper_method :logged_in?, :admin?

  # Check if the user is already logged in
  def logged_in?
    @current_user.is_a?(User)
  end
  
  def admin?
    logged_in? and @current_user.admin
  end

  def admin_required
    unless admin?
      flash[:notice] = 'You must log in as an administrator to perform that action.'
      redirect_to new_session_path
    end
  end
  
  # setup user info on each page
  def initialize_user
    @current_user = User.find_by_id(session[:user])
  end

  def not_found
    render file: "#{Rails.root.to_s}/public/404.html", layout: false, status: 404
  end

  private

    def ssl_required
      redirect_to 'https://yesl.info' if Rails.env.production? && request.protocol != 'https://'
    end

    def set_timezone
      Time.zone = 'London'
    end
end
