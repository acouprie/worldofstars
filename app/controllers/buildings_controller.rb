class BuildingsController < ApplicationController
  before_action :logged_in_user

  def index
    @buildings = Building.paginate(page: params[:page])
  end

  # GET /building/new?planet_id=1&position=1
  def new
    id = params[:planet_id]
    position = params[:position]
    @planet = Planet.find_by(id: id)
    @buildings = Building.where(["planet_id = ? and lvl = ?", id, 0]).order(:id)
    respond_to do |format|
      format.html
      format.json { render json:
        {
          :buildings => @buildings
        }
      }
    end
  end

  def cancel_upgrade_building
    id = params[:id]
    @building = Building.find_by(id: id)
    @planet = Planet.find(@building.planet_id) unless @building.nil?
    flash_message = nil
    status = nil
    if @building.nil?
      unexpected_error(2)
    elsif @building.planet_id != current_user.id
      return redirect_to planet_url(current_user.id)
    elsif @building.upgrade_start.nil?
      flash_message = "Le batiment n'est pas en amélioration"
      status = "warning"
    else
      flash_message = "L'amélioration du batiment est annulée"
      status = "success"
      @building.cancel_upgrading
    end
    respond_to do |format|
      format.js { flash.now[status] = flash_message }
      format.json { render json:
        {
          :planet => @planet
        }
      }
    end
  end

  def upgrade_building
    id = params[:id]
    @building = Building.find_by(id: id)
    @planet = Planet.find(@building.planet_id) unless @building.nil?
    flash_message = nil
    status = nil
    if @building.nil?
      unexpected_error(1)
    elsif @building.planet_id != current_user.id
      return redirect_to planet_url(current_user.id)
    elsif @planet.headquarter.lvl == 0 && @planet.headquarter != @building
      flash_message = "Améliorez d'abord le Centre de commandemant !"
      status = "warning"
    elsif !@building.upgrade_start.nil?
      flash_message = "Ce batiment est déjà en cours d'amélioration"
      status = "warning"
    elsif !@planet.check_power_availability(@building.conso_power_next_level)
      flash_message = "Energie insuffisante"
      status = "warning"
    elsif !@planet.check_ressources_availability(@building.thorium_next_level, @building.metal_next_level, @building.food_next_level)
      flash_message = "Nous manquons de ressources"
      status = "warning"
    else
      @building.upgrading
      @planet = Planet.find(@building.planet_id)
      flash_message = "Batiment en cours de construction !"
      status = "success"
    end
    respond_to do |format|
      format.js { flash.now[status] = flash_message }
      format.json { render json:
        {
          :building => @building,
          :planet => @planet
        }
      }
    end
  end

  def percent_bar
    id = params[:id]
    @building = Building.find(id)
    return if @building.planet_id != current_user.id
    @planet = Planet.find(@building.planet_id)
    @percent = compute_remaining_percent(@building)
    respond_to do |format|
      format.js
      format.json { render json:
        {
          :percent => @percent,
          :building => @building,
          :planet => @planet
        }
      }
    end
  end

  private

  def compute_remaining_percent(b)
    return 0 if b.upgrade_start.nil?
    percent = b.time_remaining * 100 / b.time_to_build
    percent = percent + 100
    percent = 100 if percent > 100
    return percent.nil? ? 0 : percent.abs
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Veuillez vous connecter pour effectuer cette action."
      redirect_to login_url
    end
  end

  def unexpected_error(nb)
    flash_message = "Erreur 0x0#{nb}, contactez l'administrateur avec ce code."
    status = "danger"
    respond_to do |format|
      format.js { flash.now[status] = flash_message }
    end
    return redirect_to planet_url(current_user.id)
  end
end
