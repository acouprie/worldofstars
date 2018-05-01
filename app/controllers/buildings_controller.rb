class BuildingsController < ApplicationController
  before_action :set_building, only: [:show, :update, :destroy]

  # GET /buildings/1
  # GET /buildings/1.json
  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_building
    @building = Building.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def building_params
    params.require(:building).permit(:name, :planet_id, :food_price, :metal_price, :thorium_price, :lvl, :conso_power, :time_to_build, :production, :position)
  end
end
