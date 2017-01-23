class AccountActifsController < ApplicationController
	def edit
		if user && !user.actifs?
			user.update_attribute(:actif, true)
			user.update_attribute(:last_connection, Time.zone.now)
			log_in user
			flash[:success] = "Console.log : joueur actif"
		end
	end
end
