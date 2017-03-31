class Planet < ApplicationRecord
	before_save :attribute_user
	validates :name, presence: true, length: { maximum: 25 }
	private
	##
	# Attribute a user to the planet
	#
	def attribute_user
		self.user_id = User.last.id
	end
end
