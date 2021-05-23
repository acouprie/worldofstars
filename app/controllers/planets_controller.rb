class PlanetsController < ApplicationController
  before_action :is_owner?, only: [:show, :edit, :update]
  # GET /planets/1
  # GET /planets/1.json
  def show
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

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def planet_params
      params.fetch(:user_id, :name)
    end

    def is_owner?
      @user = current_user
      return redirect_to login_url if @user.nil?
      @planet = Planet.find(params[:id])
      redirect_to planet_url(@user.id) unless @user.id == @planet.id
    end
end
