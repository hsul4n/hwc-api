class API::V1::Geo::Country::Division::Level1Controller < ApplicationController
  before_action :set_level1, only: [:show, :update, :destroy]

  # GET /api/v1/geo/countries/1/division/level1
  def index
    @level1s = Geo::Country::Division::Level1.where(country_params).all
    render json: @level1s
  end

  # GET /api/v1/geo/countries/1/division/level1/1
  def show
    render json: @level1
  end

  # POST /api/v1/geo/countries/1/division/level1
  def create
    @level1 = @level1.new(level1_params)

    if @level1.save
      render :show, status: :created, location: @level1
    else
      render json: @level1.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/geo/countries/1/division/level1/1
  def update
    if @level1.update(level1_params)
      render :show, status: :ok, location: @level1
    else
      render json: @level1.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/geo/countries/1/division/level1/1
  def destroy
    @level1.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_level1
    @level1 = Geo::Country::Division::Level1.find_by(country_params)
  end

  def country_params
    params.permit(:country_id, :id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def level1_params
    params.require(:level1).permit(:country_id, :name, :more)
  end
end
