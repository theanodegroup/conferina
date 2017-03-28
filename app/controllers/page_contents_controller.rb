class PageContentsController < ApplicationController
  before_action :set_page_content, only: [:show, :edit, :update, :destroy]

  # GET /page_contents
  # GET /page_contents.json
  def index
    @page_contents = PageContent.all
  end

  # GET /page_contents/1
  # GET /page_contents/1.json
  def show
  end

  # GET /page_contents/new
  def new
    @page_content = PageContent.new
  end

  # GET /page_contents/1/edit
  def edit
  end

  # POST /page_contents
  # POST /page_contents.json
  def create
    @page_content = PageContent.new(page_content_params)

    respond_to do |format|
      if @page_content.save
        format.html { redirect_to @page_content, notice: 'Page content was successfully created.' }
        format.json { render :show, status: :created, location: @page_content }
      else
        format.html { render :new }
        format.json { render json: @page_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /page_contents/1
  # PATCH/PUT /page_contents/1.json
  def update
    respond_to do |format|
      if @page_content.update(page_content_params)
        format.html { redirect_to @page_content, notice: 'Page content was successfully updated.' }
        format.json { render :show, status: :ok, location: @page_content }
      else
        format.html { render :edit }
        format.json { render json: @page_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_contents/1
  # DELETE /page_contents/1.json
  def destroy
    @page_content.destroy
    respond_to do |format|
      format.html { redirect_to page_contents_url, notice: 'Page content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_content
      @page_content = PageContent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_content_params
      params.require(:page_content).permit(:content, :bootsy_image_gallery_id)
    end
end
