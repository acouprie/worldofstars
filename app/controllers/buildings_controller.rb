class BuildingsController < ApplicationController
  def index
    @buildings = Building.paginate(page: params[:page])
  end

  def cancel_upgrade_building
    id = params[:id]
    @building = Building.find(id)
    return if @building.planet_id != current_user.id
    @planet = Planet.find(@building.planet_id)
    if @building.nil?
      respond_to do |format|
        format.js { flash.now[:danger] = "Erreur 0x02, contactez l'administrateur avec ce code" }
        format.json { render json:
          {
            :planet => @planet
          }
        }
      end
    elsif @building.upgrade_start.nil?
      respond_to do |format|
        format.js { flash.now[:warning] = "Le batiment n'est pas en amélioration" }
        format.json { render json:
          {
            :planet => @planet
          }
        }
      end
    else
      @building.cancel_upgrading
      respond_to do |format|
        format.js { flash.now[:success] = "L'amélioration du batiment est annulée" }
        format.json { render json:
          {
            :planet => @planet
          }
        }
      end
    end
  end

  def upgrade_building
    id = params[:id]
    @building = Building.find_by(id: id)
    redirect_to planet_url(current_user.id) if @building.planet_id != current_user.id
    @planet = Planet.find(@building.planet_id)
    if @building.nil?
      respond_to do |format|
        format.js { flash.now[:danger] = "Erreur 0x01, contactez l'administrateur avec ce code." }
      end
    elsif !@building.upgrade_start.nil?
      respond_to do |format|
        format.js { flash.now[:warning] = "Ce batiment est déjà en cours d'amélioration" }
      end
    elsif !@building.check_power_availability
      respond_to do |format|
        format.js { flash.now[:warning] = "Energie insuffisante" }
        format.json { render json:
          {
            :building => @building,
            :planet => @planet
          }
        }
      end
    elsif !@building.check_ressources_availability
      respond_to do |format|
        format.js { flash.now[:warning] = "Nous manquons de ressources" }
        format.json { render json:
          {
            :building => @building,
            :planet => @planet
          }
        }
      end
    else
      @building.upgrading
      @planet = Planet.find(@building.planet_id)
      respond_to do |format|
        format.js { flash.now[:success] = "Batiment en cours de construction" }
        format.json { render json:
          {
            :building => @building,
            :planet => @planet
          }
        }
      end
    end
  end

  def compute_remaining_percent(b)
    return 0 if b.upgrade_start.nil?
    time_remaining = Time.now - (b.upgrade_start + b.time_to_build)
    percent = time_remaining * 100 / b.time_to_build
    percent = percent + 100
    percent = 100 if percent > 100
    return percent.nil? ? 0 : percent.abs
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
end
