module PlanetsHelper
		 # Returns true if the given planet is the current planet.
	  def current_planet?(planet)
	    planet == current_planet
	  end

	# Returns the current planet (if any).
	def current_planet
		if (planet_id = User[:planet_id])
				@current_planet ||= Planet.find_by(id: planet_id)
		end
	end
end
