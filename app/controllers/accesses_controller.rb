class AccessesController < ApplicationController
  before_action :super_user_department_admin_access_authorized!
  before_action :set_access, only: %i[ show edit update destroy ]
  before_action :get_permissions, only: %i[ new edit ]

  # GET /accesses or /accesses.json
  def index
    base_collection = get_accesses_collection.includes(permission: [:department, :role])
    @q = base_collection.ransack(params[:q])
    @accesses = @q.result.sort_by { |ac| ac.permission.department_full_name }
    @uniqnames_for_filter = base_collection.distinct.pluck(:uniqname).sort

    unless params[:q].nil?
      render turbo_stream: turbo_stream.replace(
        :accessesListing,
        partial: "accesses/listing"
      )
    end
  end

  # GET /accesses/1 or /accesses/1.json
  def show
  end

  # GET /accesses/new
  def new
    @access = Access.new
  end

  # GET /accesses/1/edit
  def edit
  end

  # POST /accesses or /accesses.json
  def create
    @access = Access.new(access_params)

    respond_to do |format|
      if @access.save
        format.html { redirect_to access_url(@access), notice: "Access was successfully created." }
        format.json { render :show, status: :created, location: @access }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @access.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /accesses/1 or /accesses/1.json
  def update
    respond_to do |format|
      if @access.update(access_params)
        format.html { redirect_to access_url(@access), notice: "Access was successfully updated." }
        format.json { render :show, status: :ok, location: @access }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @access.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /accesses/1 or /accesses/1.json
  def destroy
    @access.destroy

    respond_to do |format|
      format.html { redirect_to accesses_url, notice: "Access was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_access
      @access = Access.find(params[:id])
    end

    def get_permissions
      @permissions_available = current_user_associated_department_permissions
    end

    # Only allow a list of trusted parameters through.
    def access_params
      params.require(:access).permit(:permission_id, :uniqname, :updated_by)
    end
end
