class UnitsController < ApplicationController
  before_action :set_planet, :set_unit

  def train
    if request.post? && @unit
      flash_message = ""
      status = "warning"
      # check if unit is owned (403)
      return unless @planet.buildings.map(&:id).include? params[:id]
      # check if queue is full
      # check if possible to build
      if !@unit.isTrainable
        flash_message = "Construisez/améliorez d'abord le centre d'entrainement !"
      # check if resources
      elsif !@planet.check_ressources_availability(
        @unit.thorium_price.to_i,
        @unit.metal_price.to_i,
        @unit.food_price.to_i
      )
        flash_message = "Nous manquons de ressources"
      else
        @unit.training
        flash_message = "Unité en cours de construction !"
        status = "success"
      end

      respond_to do |format|
        format.js { flash.now[status] = flash_message }
        format.json { render json:
          {
          }
        }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params[:id]) unless params[:id].nil?
    end

    def set_planet
      @planet = Planet.find(current_user.id) unless current_user.nil?
    end
end
