class API::V1::Geo::Country::Division::LevelsController < ApplicationController
  before_action :set_level,  only: [:show, :update, :destroy]

  # GET /api/v1/geo/countries/1/division/levels
  def index
    @levels = Geo::Country::Division::Level.where(country_params).all
    render json: @levels
  end

  # GET /api/v1/geo/countries/1/division/levels/1
  def show
    render json: @level
  end

  # POST /api/v1/geo/countries/1/division/levels
  def create
    @level = Geo::Country::Division::Level.new(level_params)

    if @level.save
      render :show, status: :created, location: @level
    else
      render json: @level.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/geo/countries/1/division/levels/1
  def update
    if @level.update(level_params)
      render :show, status: :ok, location: @level
    else
      render json: @level.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/geo/countries/1/division/levels/1
  def destroy
    @level.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_level
    @level = Geo::Country::Division::Level.find_by(country_params)
  end

  def country_params
    params.permit(:country_id, :id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def level_params
    params.require(:level).permit(:country_id, :level, :name)
  end
end
