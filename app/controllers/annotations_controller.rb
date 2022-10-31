class AnnotationsController < ApplicationController
  before_action :set_annotation, only: %i[ show edit update destroy ]

  # GET /annotations or /annotations.json
  def index
    @annotations = Annotation.all
  end

  # GET /annotations/1 or /annotations/1.json
  def show
  end

  # GET /annotations/new
  def new
    @new_annotation = Annotation.new
  end

  # GET /annotations/1/edit
  def edit
  end

  # POST /annotations or /annotations.json
  def create
    @annotation = Annotation.new(annotation_params)
    @annotation.created_by = current_user.id

    if @annotation.save
      @annotations = Annotation.where(art_item: @annotation.art_item).order("created_at DESC")
      @new_annotation = Annotation.new(art_item: @annotation.art_item)
      flash.now[:notice] = "Annotation successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /annotations/1 or /annotations/1.json
  def update
    respond_to do |format|
      if @annotation.update(annotation_params)
        format.html { redirect_to annotation_url(@annotation), notice: "Annotation was successfully updated." }
        format.json { render :show, status: :ok, location: @annotation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @annotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annotations/1 or /annotations/1.json
  def destroy
    @annotation.destroy

    respond_to do |format|
      format.html { redirect_to annotations_url, notice: "Annotation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_annotation
      @annotation = Annotation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def annotation_params
      params.require(:annotation).permit(:note, :created_by, :art_item_id)
    end
end
