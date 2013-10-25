class IssuesController < ApplicationController
  EXTERNAL_USER_ACTIONS = [:create, :edit, :new, :show, :update, :resolve]
  before_action :admin_required, except: EXTERNAL_USER_ACTIONS
  before_action :user_required, only: EXTERNAL_USER_ACTIONS
  before_action :find_issue, only: [:show, :edit, :update, :destroy, :resolve]

  def index
  end

  def show
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
      redirect_to @issue
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

  def resolve
    @issue.completed = true
    @issue.save
    Comment.create!(issue: @issue, user: current_user,
      comment: "* changed status to resolved\n\n#{params[:comment]}")
    redirect_to @issue
  end

  protected

  def find_issue
    @issue = Issue.find_by_id(params[:id])
    if @issue
      authorize_same_organisation! @issue
    else
      not_found
    end
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
