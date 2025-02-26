class ArtItemsController < ApplicationController
  before_action :check_for_authorized_access
  before_action :set_art_item, only: %i[ edit update destroy ]
  before_action :set_departments_list, only: %i[ index new create edit update ]
  before_action :set_appraisal_types, only: %i[ new create edit update ]

  # GET /art_items or /art_items.json
  def index
    # Use a single query to get the base collection with proper eager loading
    base_collection = get_optimized_artitems_collection

    # Apply ransack filtering if search params exist
    @q = base_collection.ransack(params[:q])
    @art_items = @q.result

    # Group items by department to avoid N+1 queries in the view
    @items_by_department = @art_items.group_by(&:department_id)

    # Get departments in a single query for both the form and view usage
    department_ids = @items_by_department.keys
    @departments = Department.where(id: department_ids).order(:fullname)
    @departments_by_id = @departments.index_by(&:id)

    # Cache appraisal type IDs to avoid redundant queries
    @appraisal_type_ids = Rails.cache.fetch("appraisal_type_ids", expires_in: 30.minutes) do
      @art_items.pluck(:appraisal_type_id).uniq.sort
    end

    unless params[:q].nil?
      render turbo_stream: turbo_stream.replace(
        :itemsListing,
        partial: "art_items/listing"
      )
    end
  end

  # GET /art_items/1 or /art_items/1.json
  def show
    # Use optimized scope for loading the art item with all needed associations
    @art_item = ArtItem.with_all_associations.find(params[:id])

    # Check authorization after eager loading to avoid unnecessary queries
    unless is_super_user! || current_user_departments.include?(@art_item.department_id)
      flash.alert = "Not Authorized."
      redirect_to root_path and return
    end

    # Preload annotations in a single query and cache in instance variable
    @annotations = @art_item.annotations.order("created_at DESC")
    @new_annotation = Annotation.new(art_item: @art_item)
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

    # Ensure user has access to the selected department
    unless is_super_user! || current_user_departments.include?(@art_item.department_id.to_i)
      flash.alert = "Not Authorized to create items for this department."
      redirect_to art_items_path and return
    end

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
    # Ensure user has access to the selected department if changing it
    if art_item_params[:department_id].present? &&
       !is_super_user! &&
       !current_user_departments.include?(art_item_params[:department_id].to_i)
      flash.alert = "Not Authorized to move items to this department."
      redirect_to edit_art_item_path(@art_item) and return
    end

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
      # This is now only used for edit, update, and destroy actions
      # The show action has its own optimized query
      @art_item = ArtItem.find(params[:id])
      unless is_super_user! || current_user_departments.include?(@art_item.department_id)
        flash.alert = "Not Authorized."
        redirect_to root_path
      end
    end

    def set_departments_list
      # Use department objects instead of just IDs for form selection
      @departments_list = current_user_department_objects
    end

    def set_appraisal_types
      # Cache this query to avoid repeated database hits
      @appraisal_types = Rails.cache.fetch("appraisal_types", expires_in: 1.hour) do
        AppraisalType.order(:classification).to_a
      end
    end

    def get_optimized_artitems_collection
      if is_super_user!
        # SuperUsers see all items
        ArtItem.for_listing.order('departments.fullname')
      else
        # Department Admins and other users only see their departments' items
        ArtItem.for_listing
               .where(department_id: current_user_departments)
               .order('departments.fullname')
      end
    end

    def get_artitems_collection
      if is_super_user!
        ArtItem.active_with_departments
      else
        ArtItem.active_with_departments.where(department_id: current_user_departments)
      end
    end

    # Only allow a list of trusted parameters through.
    def art_item_params
      params.require(:art_item).permit(:description, :location_building, :location_room, :value_cost, :date_acquired, :appraisal_type_id, :appraisal_description, :protection, :archived, :department_id, :updated_by, :department_contact, documents: [], images: [])
    end
end
