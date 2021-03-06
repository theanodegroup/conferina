class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: [:export, :show, :edit, :update, :destroy]
  before_action :set_notable, only: [:show, :edit, :update, :destroy]


  def export
    if @note.present?
      Exporter.export_notes(@note).deliver_now
      flash[:error] = "We've emailed your notes to you at #{current_user.email}"
    else
      flash[:error] = "Could not send notes, notable type not present"
    end

    respond_to do |format|
      format.js # AJAX only
    end
  end

  def bulk_export
    notable_type = params[:notable_type]

    if notable_type.present?
      notes = Note.where(notable_type: notable_type, user_id: current_user.id)
      if notes.empty?
        flash[:error] = "There are no notes to send you"
      else
        Exporter.bulk_export_notes(notes).deliver_now
      end

      flash[:error] = "We've emailed your notes to you at #{current_user.email}"
    else
      flash[:error] = "Could not bulk export notes, notable type not present"
    end

    respond_to do |format|
      format.js # AJAX only
    end
  end

  def view
    # @todo: use a better approach, this is not ideal

    # Treat it as either new or show depending on if notes already exist
      notable_params[:user_id] = current_user

      # Get the notable query and value by extracting it from params
      notable_id = notable_params[:notable_id].to_i
      notable_type = notable_params[:notable_type].constantize
      @notable = notable_type.find_by(id: notable_id)

      @note = Note.find_by(notable_params)

      if @note.nil?
        # Create new note
        @note = Note.new(notable_params)
        new
        render 'notes/new'
      else
        # View existing note
        show
        render 'notes/show'
      end

  end

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new unless @note.present?
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html do
        redirect_to event_data_path,
                    notice: 'Note was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    def set_notable
      @notable = @note.notable_type.constantize.find_by(id: @note.notable_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:content, :notable_id, :notable_type, :user_id)
    end

    def notable_params
      params.permit(:notable_id, :notable_type, :user_id)
    end
end
