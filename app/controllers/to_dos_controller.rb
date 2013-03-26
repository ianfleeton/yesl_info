class ToDosController < ApplicationController
  before_filter :admin_required
  before_filter :find_to_do, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @to_do = ToDo.new(
      setter_id: @current_user.id,
      organisation_id: params[:organisation_id],
      date_due: Date.today + 1.week
    )
  end

  def create
    @to_do = ToDo.new(to_do_params)
    @to_do.completed = false
    if @to_do.save
      ToDoNotifier.new_task(@to_do).deliver
      flash[:notice] = 'To-do saved.'
      redirect_to organisation_path(@to_do.organisation)
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @to_do.update_attributes(to_do_params)
      flash[:notice] = 'To-do saved.'
      redirect_to organisation_path(@to_do.organisation)
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
          destroy_to_do(id)
          flash[:notice] = 'To-do(s) deleted.'
        elsif(params[:commit] == 'Mark Selected as Complete')
          mark_as_complete(id)
          flash[:notice] = 'To-do(s) marked as complete.'
        end
      end
    end
    redirect_to action: 'index'
  end

  protected

  def find_to_do
    @to_do = ToDo.find_by_id(params[:id])
    not_found unless @to_do
  end

  def destroy_to_do(id)
    ToDo.find(id).destroy
  end

  def mark_as_complete(id)
    to_do = ToDo.find(id)
    to_do.completed = true
    to_do.save
    ToDoNotifier.marked_as_complete(to_do).deliver
  end

  def to_do_params
    params.require(:to_do).permit(:assignee_id, :date_due, :details, :estimated_time, :organisation_id, :priority, :setter_id, :title)
  end
end
