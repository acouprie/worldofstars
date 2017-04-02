class PlanetsController < ApplicationController

	def index
		@planets = Planet.paginate(page: params[:page])
  end

	def show
		@planet = Planet.find(params[:id])
	end

	def new
		@planet = Planet.new
	end

	def create
		@planet = Planet.new(planet_params)
		if @planet.save
			flash[:info] = "A vos ordres !"
		else
			render 'new'
		end
	end

	def edit
	end
  	
  def destroy
 	end

	private
	def planet_params
		params.require(:planet).permit(:name)
	end
end
