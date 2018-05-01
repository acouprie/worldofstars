class PlanetsController < ApplicationController
  before_action :set_planet, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user

  # GET /planets/1
  # GET /planets/1.json
  def show
    @planet = Planet.find(params[:id])
    @user = current_user
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

  def create_farm
    set_planet.create_farm
  end

  def create_solar
    set_planet.create_solar
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_planet
      @planet = Planet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def planet_params
      params.fetch(:user_id, :name)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Veuillez vous connecter pour effectuer cette action."
        redirect_to login_url
      end
    end
end
