class SearchController < ApplicationController
  before_action :admin_required

  def index
    if params[:query].present?
      q = "%#{params[:query]}%"
      @domains = Domain.where('name LIKE ?', q).order('updated_at DESC').limit(5)
      @note_pads = NotePad.where('title LIKE ? OR content LIKE ?', q, q).order('updated_at DESC').limit(10)
      @organisations = Organisation.where('name LIKE ?', q).order('updated_at DESC').limit(7)
      @timesheet_entries = TimesheetEntry.where('description LIKE ?', q).order('updated_at DESC').limit(15)
      @users = User.where('name LIKE ?', q).order('updated_at DESC').limit(5)
    end
    render layout: false if request.xhr?
  end
end
