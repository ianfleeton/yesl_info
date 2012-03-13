# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  before_filter :initialize_user
  
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
      redirect_to :controller => 'sessions', :action => 'new'
    end
  end
  
  # setup user info on each page
  def initialize_user
    @current_user = User.find_by_id(session[:user])
  end
end
