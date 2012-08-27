class NotePadsController < ApplicationController
  before_filter :find_note_pad, :except => [:new, :create]

  def new
    @note_pad = NotePad.new
    @note_pad.title = 'Notes'
    @note_pad.organisation_id = params[:organisation_id]
  end

  def create
    @note_pad = NotePad.new(params[:note_pad])
    if @note_pad.save
      flash[:notice] = "Note pad saved."
      redirect_to organisation_path(@note_pad.organisation)
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @note_pad.update_attributes(params[:note_pad])
      flash[:notice] = 'Note pad saved.'
      redirect_to organisation_path(@note_pad.organisation)
    else
      render action: 'edit'
    end
  end

  def destroy
    @note_pad.destroy
    flash[:notice] = "Note pad deleted."
    redirect_to organisation_path(@note_pad.organisation)
  end

  protected

  def find_note_pad
    @note_pad = NotePad.find(params[:id])
  end
end
