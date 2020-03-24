require 'csv'
require 'open-uri'

class API::V1::Medical::Disease::CasesController < ApplicationController
  before_action :set_last_case
  before_action -> { Medical::Disease::Case::FetchJob.perform_now(@last_case) }, if: -> { @last_case.date < Date.yesterday }
  before_action :set_case, only: [:show, :update, :destroy]

  # GET /api/v1/medical/diseases/1/cases/total
  def total
    @by_type = {
      heal: Medical::Disease::Case.heal.where(query_params).count,
      sure: Medical::Disease::Case.sure.where(query_params).count,
      died: Medical::Disease::Case.died.where(query_params).count,
    }

    render json: @by_type
  end

  # GET /api/v1/medical/diseases/cases/timeline
  def timeline
    @by_date = Medical::Disease::Case.where(query_params).group(:date).count
    
    render json: @by_date
  end

  # GET /api/v1/medical/diseases/1/cases
  # def index
  #   @cases = Medical::Disease::Case.where(query_params).all
  #   render json: @cases
  # end

  # GET /api/v1/medical/diseases/1/cases/1
  def show
    render json: @case
  end

  # POST /api/v1/medical/diseases/1/cases
  def create
    @case = @case.new(case_params)

    if @case.save
      render :show, status: :created, location: @case
    else
      render json: @case.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/medical/diseases/1/cases/1
  def update
    if @case.update(case_params)
      render :show, status: :ok, location: @case
    else
      render json: @case.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/medical/diseases/1/cases/1
  def destroy
    @case.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_case
    @case = Medical::Disease::Case.find_by(query_params)
  end

  def set_last_case
    @last_case = Medical::Disease::Case.where(params.permit[:disease_id]).last
  end

  def query_params
    params.permit(:continent_id, :country_id, :level1_id, :disease_id, :type, :id).tap do |item|
      if params[:from].present? || params[:to].present?
        unless params[:from].present?
          first_case = Medical::Disease::Case.where(params.permit[:disease_id]).first
        end
        item[:date] = (params[:from] || first_case.date.to_s)..(params[:to] || @last_case.date.to_s)
      end
    end
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def case_params
    params.require(:case).permit(:id, :continent_id, :country_id, :level1_id, :disease_id, :type, :date)
  end
end
