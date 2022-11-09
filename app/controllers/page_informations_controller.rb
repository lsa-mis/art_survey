class PageInformationsController < ApplicationController
  before_action :set_page_information, only: %i[ show edit update destroy ]

  # GET /page_informations or /page_informations.json
  def index
    @page_informations = PageInformation.all
  end

  # GET /page_informations/1 or /page_informations/1.json
  def show
  end

  # GET /page_informations/new
  def new
    @page_information = PageInformation.new
  end

  # GET /page_informations/1/edit
  def edit
  end

  # POST /page_informations or /page_informations.json
  def create
    @page_information = PageInformation.new(page_information_params)

    respond_to do |format|
      if @page_information.save
        format.html { redirect_to page_information_url(@page_information), notice: "Page information was successfully created." }
        format.json { render :show, status: :created, location: @page_information }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @page_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /page_informations/1 or /page_informations/1.json
  def update
    respond_to do |format|
      if @page_information.update(page_information_params)
        format.html { redirect_to page_information_url(@page_information), notice: "Page information was successfully updated." }
        format.json { render :show, status: :ok, location: @page_information }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @page_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_informations/1 or /page_informations/1.json
  def destroy
    @page_information.destroy

    respond_to do |format|
      format.html { redirect_to page_informations_url, notice: "Page information was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_information
      @page_information = PageInformation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_information_params
      params.require(:page_information).permit(:location, :content)
    end
end
