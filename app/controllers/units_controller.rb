class UnitsController < ApplicationController
  before_action :set_planet, :set_unit

  def train
    if request.post? && @unit
      # check if unit is owned (403)
      return head(:forbidden) unless @planet.units.map(&:id).include? params[:id].to_i
      flash_message = ""
      status = "warning"

      param_nb_unit = "nb_unit_" + @unit.id.to_s
      nb_unit = check_nb_unit(params[param_nb_unit.to_sym].to_i)
      # check if queue is full
      # check if possible to build
      if !@unit.isTrainable
        flash_message = "Améliorez d'abord le centre d'entrainement !"
      # check if resources
      elsif !@planet.check_ressources_availability(
        @unit.thorium_price.to_i * nb_unit,
        @unit.metal_price.to_i * nb_unit,
        @unit.food_price.to_i * nb_unit
      )
        flash_message = "Nous manquons de ressources"
      else
        @unit.training(nb_unit)
        flash_message = "Unité(s) en cours de construction !"
        status = "success"
      end

      respond_to do |format|
        format.js { flash.now[status] = flash_message }
        format.json { render json:
          {
            :unit => @unit,
            :planet => @planet
          }
        }
      end
    end
  end

  private

    def set_unit
      @unit = Unit.find(params[:id]) unless params[:id].nil?
    end

    def set_planet
      @planet = Planet.find(current_user.id) unless current_user.nil?
    end

    def check_nb_unit(nb_unit)
      # TODO: check training and military lvl
      if nb_unit > 15
        return 15
      elsif nb_unit < 1
        return 1
      else
        return nb_unit
      end
    end
end
