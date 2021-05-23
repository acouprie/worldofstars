class BuildingsController < ApplicationController
  before_action :building_params

  def index
    @buildings = Building.paginate(page: params[:page])
  end

  def upgrade_building
    id = params[:id]
    building = Building.find(id)
    if building.nil?
      respond_to do |format|
        format.js { flash.now[:danger] = "Erreur 0x01, contactez l'administrateur." }
      end
    elsif !building.check_power_availability
      respond_to do |format|
        format.js { flash.now[:warning] = "Energie insuffisante" }
      end
    elsif !building.check_ressources_availability
      respond_to do |format|
        format.js { flash.now[:warning] = "Nous manquons de ressources" }
      end
    else
      @building = current_planet.upgrade_building(id)
      respond_to do |format|
        format.js { flash.now[:success] = "Batiment en cours de construction" }
        format.json { render json: @building }
      end
    end
  end

  def compute_remaining_percent(b)
    time_remaining = Time.now - (b.upgrade_start + b.time_to_build)
    percent = time_remaining * 100 / b.time_to_build
    percent = percent + 100
    percent = 100 if percent > 100
    return percent.nil? ? 0 : percent.abs
  end

  def percent_bar
    id = params[:id]
    @building = Building.find(id)
    return if @building.upgrade_start.nil?
    @percent = compute_remaining_percent(@building)
    respond_to do |format|
      format.js
      format.json { render json: @percent }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def building_params
    params.require(:building).permit(:name, :planet_id, :food_price, :metal_price, :thorium_price, :lvl, :conso_power, :time_to_build, :production, :position)
  end
end
