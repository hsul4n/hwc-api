class API::V1::Geo::CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/geo/countries
  def index
    @countries = Geo::Country.where(query_params).all
    render json: @countries
  end

  # GET /api/v1/geo/countries/1
  def show
    render json: @country
  end

  # POST /api/v1/geo/countries
  def create
    @country = Geo::Country.new(country_params)

    if @country.save
      render :show, status: :created, location: @country
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/geo/countries/1
  def update
    if @country.update(country_params)
      render :show, status: :ok, location: @country
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/geo/countries/1
  def destroy
    @country.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_country
    @country = Geo::Country.find(params[:id])
  end

  def query_params
    params.permit(:continent_id, :id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def country_params
    params.require(:country).permit(:continent_id, :name, :iso, :code)
  end
end
