class NotePadsController < ApplicationController
  before_action :find_note_pad, :except => [:new, :create]

  def new
    @note_pad = NotePad.new
    @note_pad.title = 'Notes'
    @note_pad.organisation_id = params[:organisation_id]
  end

  def create
    @note_pad = NotePad.new(note_pad_params)
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
    if @note_pad.update_attributes(note_pad_params)
      flash[:notice] = 'Note pad saved.'
      redirect_to organisation_path(@note_pad.organisation)
    else
      render action: 'edit'
    end
  end

  def destroy
    @note_pad.destroy
    redirect_to @note_pad.organisation, notice: 'Note pad deleted.'
  end

  protected

  def find_note_pad
    @note_pad = NotePad.find(params[:id])
  end

  def note_pad_params
    params.require(:note_pad).permit(:content, :organisation_id, :title)
  end
end
