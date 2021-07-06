class StaticPagesController < ApplicationController
	def home
    current_user.update_last_connection unless current_user.nil?
    user_record = Redis.current.get("user_record").to_i
    connected_user_number = User.where((["last_connection > ?", 15.minutes.ago])).count
    Redis.current.set("user_record", connected_user_number) if connected_user_number > user_record
	end

  def contact
  end
end
