class BuildingsController < ApplicationController
  before_action :logged_in_user, :set_planet, :set_building

  # POST /building/upgrade, params[:id]
  # GET /building/upgrade?planet_id=1&position=1
  def upgrade
    # GET
    if request.get?
      position = params[:position]
      return planet_url(@planet.id) if position.nil?
      @building = Building.where(["planet_id = ? and position = ?", @planet.id, position]).first
      unless @building.nil?
        @building.food_price = @building.next_level.dig(:food_price).to_i
        @building.metal_price = @building.next_level.dig(:metal_price).to_i
        @building.thorium_price = @building.next_level.dig(:thorium_price).to_i
        @building.time_to_build = @building.next_level.dig(:time_to_build).to_i
        @building.production = @building.next_level.dig(:production).to_i ||= 0
        @building.conso_power = @building.next_level.dig(:conso_power).to_i ||= 0
        @buildings = [@building]
      end
      respond_to do |format|
        format.html
        format.json { render json:
          {
            :buildings => @buildings
          }
        }
      end
    end

    # POST
    if request.post?
      flash_message = ""
      status = "warning"
      message_dep = @building.hasDependencies unless @building.nil?

      if @building.nil?
        return unexpected_error(1)
      elsif @building.planet_id != current_user.id
        return redirect_to planet_url(current_user.id)
      elsif message_dep
        flash_message = message_dep
      elsif !@building.upgrade_start.nil?
        flash_message = "Ce bâtiment est déjà en cours d'amélioration"
      elsif !@planet.buildings.select { |b| !b.upgrade_start.nil? }.empty?
        flash_message = "Un bâtiment est déjà en cours d'amélioration."
      elsif !@planet.check_power_availability(@building.next_level.dig(:conso_power).to_i ||= 0)
        flash_message = "Energie insuffisante"
      elsif !@planet.check_ressources_availability(@building.next_level.dig(:thorium_price).to_i, @building.next_level.dig(:metal_price).to_i, @building.next_level.dig(:food_price).to_i)
        flash_message = "Nous manquons de ressources"
      else
        position ||= params[:position].to_i
        if @building.lvl == 0 && !position.nil?
          @building.set_position(position)
          redirect_to planet_url(@planet)
        end
        @building.upgrading
        @planet = set_planet
        flash_message = "Bâtiment en cours de construction !"
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
  end

  def cancel_upgrade_building
    flash_message = nil
    status = nil
    if @building.nil?
      unexpected_error(2)
    elsif @building.planet_id != current_user.id
      return redirect_to planet_url(current_user.id)
    elsif @building.upgrade_start.nil?
      flash_message = "Le bâtiment n'est pas en amélioration"
      status = "warning"
    else
      flash_message = "L'amélioration du bâtiment est annulée"
      status = "success"
      @building.cancel_upgrading
      @planet = set_planet
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

  def percent_bar
    return if @building.planet_id != current_user.id
    @percent = compute_remaining_percent(@building)
    @buildings_finished = Building.where(["planet_id = ? and lvl != ?", @planet.id, 0]).order(:id)
    respond_to do |format|
      format.js
      format.json { render json:
        {
          :percent => @percent,
          :building => @building,
          :buildings_finished => @buildings_finished,
          :planet => @planet
        }
      }
    end
  end

  private

  def compute_remaining_percent(b)
    return 0 if b.upgrade_start.nil?
    percent = b.time_remaining * 100 / b.next_level.dig(:time_to_build).to_i
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

  def set_building
    @building = Building.find_by(id: params[:id]) unless params[:id].nil?
    @buildings = Building.where(["planet_id = ? and lvl = ? and position is ?", @planet.id, 0, nil]).order(:id).to_a.dup
    @buildings.each do |building|
      @buildings -= [building] if building.hasDependencies
    end
  end

  def set_planet
    @planet = Planet.find(current_user.id) unless current_user.nil?
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
