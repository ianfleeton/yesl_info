class DatabasesController < ApplicationController
  before_action :admin_required
  before_action :find_database, except: [:new, :create]

  def new
    @database = Database.new
    @database.organisation_id = params[:organisation_id]
  end

  def create
    @database = Database.new(database_params)
    if @database.save
      flash[:notice] = "Database saved."
      redirect_to organisation_path(@database.organisation)
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @database.update_attributes(database_params)
      flash[:notice] = 'Database saved.'
      redirect_to organisation_path(@database.organisation)
    else
      render action: 'edit'
    end
  end

  def destroy
    @database.destroy
    redirect_to @database.organisation, notice: 'Database deleted.'
  end

  protected

  def find_database
    @database = Database.find(params[:id])
  end

  def database_params
    params.require(:database).permit(:host, :location, :name, :organisation_id, :password, :username)
  end
end
