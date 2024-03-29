class ArtItemsController < ApplicationController
  before_action :check_for_authorized_access
  before_action :set_art_item, only: %i[ show edit update destroy ]
  before_action :set_departments_list, only: %i[ index new create edit update ]
  before_action :set_appraisal_types, only: %i[ new create edit update ]

  # GET /art_items or /art_items.json
  def index
    @q = get_artitems_collection.ransack(params[:q])
    @art_items = @q.result.order('department.fullname')
    @departments_result = @art_items.pluck(:department_id).uniq
    @appraisal_type_ids = get_artitems_collection.pluck(:appraisal_type_id).uniq.sort
    @departments = Department.where(id: (ArtItem.where(department_id: @departments_list).pluck(:department_id).uniq)).order(:fullname)
 
    unless params[:q].nil?
      render turbo_stream: turbo_stream.replace(
      :itemsListing,
      partial: "art_items/listing"
    )
    end
  end

  # GET /art_items/1 or /art_items/1.json
  def show
    @new_annotation = Annotation.new(art_item: @art_item)
    @annotations = @art_item.annotations.order("created_at DESC")
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

  def delete_file_attachment
    @delete_file = ActiveStorage::Attachment.find(params[:id])
    @delete_file.purge
    redirect_back(fallback_location: request.referer)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_art_item
      @art_item = ArtItem.find(params[:id])
      redirect_to root_path unless current_user_departments.include?(@art_item.department)
      flash.alert = "Not Authorized." unless current_user_departments.include?(@art_item.department)
    end

    def set_departments_list
      @departments_list = current_user_departments
    end

    def set_appraisal_types
      @appraisal_types = AppraisalType.all
    end

    def get_artitems_collection
      ArtItem.active_with_departments.where(department_id: current_user_departments)
    end

    # Only allow a list of trusted parameters through.
    def art_item_params
      params.require(:art_item).permit(:description, :location_building, :location_room, :value_cost, :date_acquired, :appraisal_type_id, :appraisal_description, :protection, :archived, :department_id, :updated_by, :department_contact, documents: [], images: [])
    end
end
