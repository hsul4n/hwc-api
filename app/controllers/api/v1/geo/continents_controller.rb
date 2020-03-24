class API::V1::Geo::ContinentsController < ApplicationController
  # include API::Isoable
  before_action :set_continent, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/geo/continents
  def index
    @continents = Geo::Continent.all
    render json: @continents
  end

  # GET /api/v1/geo/continents/1
  def show
    render json: @continent
  end

  # POST /api/v1/geo/continents
  def create
    @continent = Geo::Continent.new(continent_params)

    if @continent.save
      render :show, status: :created, location: @continent
    else
      render json: @continent.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/geo/continents/1
  def update
    if @continent.update(continent_params)
      render :show, status: :ok, location: @continent
    else
      render json: @continent.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/geo/continents/1
  def destroy
    @continent.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_continent
    @continent = Geo::Continent.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def continent_params
    params.require(:continent).permit(:name, :iso, :code)
  end
end
