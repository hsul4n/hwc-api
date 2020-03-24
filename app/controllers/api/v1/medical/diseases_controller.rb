class API::V1::Medical::DiseasesController < ApplicationController
  before_action :set_disease, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/medical/diseases
  def index
    @diseases = Medical::Disease.all
    render json: @diseases
  end

  # GET /api/v1/medical/diseases/1
  def show
    render json: @disease
  end

  # POST /api/v1/medical/diseases
  def create
    @disease = Medical::Disease.new(disease_params)

    if @disease.save
      render :show, status: :created, location: @disease
    else
      render json: @disease.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/medical/diseases/1
  def update
    if @disease.update(disease_params)
      render :show, status: :ok, location: @disease
    else
      render json: @disease.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/medical/diseases/1
  def destroy
    @disease.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_disease
    @disease = Medical::Disease.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def disease_params
    params.require(:disease).permit(:id, :name, :description)
  end
end
