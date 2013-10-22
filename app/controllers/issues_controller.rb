class IssuesController < ApplicationController
  before_action :admin_required, except: [:new, :create]
  before_action :user_required, only: [:new, :create]
  before_action :find_issue, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @issue = Issue.new(
      setter_id: current_user.id,
      organisation_id: params[:organisation_id],
      date_due: Date.today + 1.week
    )
  end

  def create
    @issue = Issue.new(issue_params)

    unless admin?
      @issue.organisation = current_user.organisation
      @issue.setter = current_user
    end

    @issue.completed = false
    if @issue.save
      IssueNotifier.new_task(@issue).deliver
      flash[:notice] = 'Issue saved.'
      redirect_to organisation_path(@issue.organisation)
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @issue.update_attributes(issue_params)
      flash[:notice] = 'Issue saved.'
      redirect_to organisation_path(@issue.organisation)
    else
      render action: 'edit'
    end
  end

  def destroy
  end

  def update_multiple
    unless params[:id].nil?
      params[:id].each_key do |id|
        if(params[:commit] == 'Delete Selected')
          destroy_issue(id)
          flash[:notice] = 'Issue(s) deleted.'
        elsif(params[:commit] == 'Mark Selected as Complete')
          mark_as_complete(id)
          flash[:notice] = 'Issue(s) marked as complete.'
        end
      end
    end
    redirect_to action: 'index'
  end

  def calendar
    @issues = Issue.all
  end

  protected

  def find_issue
    @issue = Issue.find_by_id(params[:id])
    not_found unless @issue
  end

  def destroy_issue(id)
    Issue.find(id).destroy
  end

  def mark_as_complete(id)
    issue = Issue.find(id)
    issue.completed = true
    issue.save
    IssueNotifier.marked_as_complete(issue).deliver
  end

  def issue_params
    params.require(:issue).permit(:assignee_id, :date_due, :details, :estimated_time, :organisation_id, :priority, :setter_id, :title)
  end
end
