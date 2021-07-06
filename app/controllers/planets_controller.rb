class PlanetsController < ApplicationController
  before_action :is_owner?, only: [:show, :edit, :update]
  before_action :buildings
  after_action :update_activity

  # GET /planets/:name
  # GET /planets/:name.json
  def show
    respond_to do |format|
      format.js
      format.html
      format.json { render json:
        {
          :buildings => @buildings,
          :buildings_finished => @buildings_finished
        }
      }
    end
  end

  # GET /planets/new
  def new
    @planet = Planet.new
  end

  # GET /planets/:name/edit
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

  # PATCH/PUT /planets/:name
  # PATCH/PUT /planets/:name.json
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

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def planet_params
    params.fetch(:user_id, :name)
  end

  def is_owner?
    @user = current_user
    return redirect_to login_url if @user.nil?
    @planet = Planet.find_by(name: params[:name])
    redirect_to planet_url(@user.id) if @planet.nil? || @user.id != @planet.id
  end

  def buildings
    @buildings_finished = Building.where(["planet_id = ? and lvl != ?", @planet.id, 0]).order(:id)
    @buildings = Building.where(["planet_id = ? and upgrade_start is not ?", @planet.id, nil]).order(:id)
  end

  def update_activity
    @user.update_last_connection
  end
end
