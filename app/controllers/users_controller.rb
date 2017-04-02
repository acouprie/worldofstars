class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
	before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

	def index
		@users = User.where(activated: true).paginate(page: params[:page])
   end

	def show
		@user = User.find(params[:id])
		redirect_to root_url and return unless @users = User.where(activated: true)
	end

	def new
		@user = @user.users.new
		#@planet = @user.planets.create(name:"Mars")
		#@user.add_planet_to_user("Terre")
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@user.send_activation_email
			flash[:info] = "Activez votre compte via le lien reçu par e-mail."
			redirect_to root_url
		else
			render 'new'
		end
	end

	def edit
	end

	def update
	    if @user.update_attributes(user_params)
      		flash[:success] = "Profil mis à jour !"
      		redirect_to @user
    	else
      		render 'edit'
    	end
  	end

  	def destroy
	    User.find(params[:id]).destroy
	    flash[:success] = "User deleted"
	    redirect_to users_url
 	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password,
				:password_confirmation)
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
	    # Confirms the correct user.
	    def correct_user
	      	@user = User.find(params[:id])
	      	redirect_to(root_url) unless current_user?(@user)
	    end

	    # Confirms an admin user.
    	def admin_user
      		redirect_to(root_url) unless current_user.admin?
    	end

end
