class ArtItemsController < ApplicationController
  before_action :set_art_item, only: %i[ show edit update destroy ]

  # GET /art_items or /art_items.json
  def index
    @art_items = ArtItem.all
  end

  # GET /art_items/1 or /art_items/1.json
  def show
  end

  # GET /art_items/new
  def new
    @art_item = ArtItem.new
  end

  # GET /art_items/1/edit
  def edit
  end

  # POST /art_items or /art_items.json
  def create
    @art_item = ArtItem.new(art_item_params)

    respond_to do |format|
      if @art_item.save
        format.html { redirect_to art_item_url(@art_item), notice: "Art item was successfully created." }
        format.json { render :show, status: :created, location: @art_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @art_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /art_items/1 or /art_items/1.json
  def update
    respond_to do |format|
      if @art_item.update(art_item_params)
        format.html { redirect_to art_item_url(@art_item), notice: "Art item was successfully updated." }
        format.json { render :show, status: :ok, location: @art_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @art_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /art_items/1 or /art_items/1.json
  def destroy
    @art_item.destroy

    respond_to do |format|
      format.html { redirect_to art_items_url, notice: "Art item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_art_item
      @art_item = ArtItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def art_item_params
      params.fetch(:art_item, {})
    end
end
