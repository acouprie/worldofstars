class ApplicationController < ActionController::Base
	# added during the tutorial but cause a token error when log out
	# protect_from_forgery with: :exception
	include SessionsHelper
end
