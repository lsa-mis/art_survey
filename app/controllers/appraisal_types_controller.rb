class AppraisalTypesController < ApplicationController
  before_action :set_appraisal_type, only: %i[ show edit update destroy ]
  before_action :is_super_user?
  
  # GET /appraisal_types or /appraisal_types.json
  def index
    @appraisal_types = AppraisalType.all
  end

  # GET /appraisal_types/1 or /appraisal_types/1.json
  def show
  end

  # GET /appraisal_types/new
  def new
    @appraisal_type = AppraisalType.new
  end

  # GET /appraisal_types/1/edit
  def edit
  end

  # POST /appraisal_types or /appraisal_types.json
  def create
    @appraisal_type = AppraisalType.new(appraisal_type_params)

    respond_to do |format|
      if @appraisal_type.save
        format.html { redirect_to appraisal_type_url(@appraisal_type), notice: "Appraisal type was successfully created." }
        format.json { render :show, status: :created, location: @appraisal_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appraisal_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appraisal_types/1 or /appraisal_types/1.json
  def update
    respond_to do |format|
      if @appraisal_type.update(appraisal_type_params)
        format.html { redirect_to appraisal_type_url(@appraisal_type), notice: "Appraisal type was successfully updated." }
        format.json { render :show, status: :ok, location: @appraisal_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appraisal_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appraisal_types/1 or /appraisal_types/1.json
  def destroy
    @appraisal_type.destroy

    respond_to do |format|
      format.html { redirect_to appraisal_types_url, notice: "Appraisal type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appraisal_type
      @appraisal_type = AppraisalType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appraisal_type_params
      params.require(:appraisal_type).permit(:classification, :description, :updated_by)
    end
end
