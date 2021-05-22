class PlanetsController < ApplicationController
  # GET /planets/1
  # GET /planets/1.json
  def show
    @planet = Planet.find(params[:id])
    @user = current_user
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /planets/new
  def new
    @planet = Planet.new
  end

  # GET /planets/1/edit
  def edit
  end

  # POST /planets
  # POST /planets.json
  def create
    @planet = Planet.new(planet_params)
    respond_to do |format|
      if @planet.save
        format.html { redirect_to @planet, notice: 'Planet was successfully created.' }
        format.json { render :show, status: :created, location: @planet }
      else
        format.html { render :new }
        format.json { render json: @planet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planets/1
  # PATCH/PUT /planets/1.json
  def update
    respond_to do |format|
      if @planet.update(planet_params)
        format.html { redirect_to @planet, notice: 'Planet was successfully updated.' }
        format.json { render :show, status: :ok, location: @planet }
      else
        format.html { render :edit }
        format.json { render json: @planet.errors, status: :unprocessable_entity }
      end
    end
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
      current_planet.upgrade_building(id)
      respond_to do |format|
        format.js { flash.now[:success] = "Batiment en cours de construction" }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def planet_params
      params.fetch(:user_id, :name)
    end
end
