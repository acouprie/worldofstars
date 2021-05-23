class PlanetsController < ApplicationController
  # GET /planets/1
  # GET /planets/1.json
  def show
    @user = current_user
    return redirect_to login_url if @user.nil?
    @planet = Planet.find(params[:id])
    return redirect_to planet_url(@user.id) unless @planet.id == @user.id
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

  # TODO: move all of this to building
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
    def planet_params
      params.fetch(:user_id, :name)
    end
end
