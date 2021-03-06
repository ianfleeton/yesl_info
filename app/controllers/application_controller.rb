require 'errors'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  before_action :set_timezone, :ssl_required, :initialize_user

  # make these available as ActionView helper methods.
  helper_method :logged_in?, :admin?, :current_user

  attr_reader :current_user

  rescue_from Errors::AuthorizationError, with: :unauthorized

  # Check if the user is already logged in
  def logged_in?
    current_user.is_a?(User)
  end

  def admin?
    logged_in? and current_user.admin?
  end

  def unauthorized
    flash[:notice] = 'Unauthorised.'
    redirect_to new_session_path
  end

  def admin_required
    unless admin?
      flash[:notice] = 'You must log in as an administrator to perform that action.'
      redirect_to new_session_path
    end
  end

  def user_required
    unless logged_in?
      flash[:notice] = 'You must be logged in to perform that action.'
      redirect_to new_session_path
    end
  end

  def authorize_same_organisation!(object)
    return if admin?
    raise Errors::AuthorizationError unless same_organisation_as? object
  end

  def same_organisation_as? object
    if object.is_a? Organisation
      logged_in? && current_user.organisation == object
    else
      logged_in? && current_user.organisation == object.organisation
    end
  end

  # setup user info on each page
  def initialize_user
    @current_user = User.find_by(id: session[:user])
  end

  def not_found
    render file: "#{Rails.root.to_s}/public/404.html", layout: false, status: 404
  end

  private

    def ssl_required
      redirect_to root_url if Rails.env.production? && request.protocol != 'https://'
    end

    def set_timezone
      Time.zone = 'London'
    end
end
