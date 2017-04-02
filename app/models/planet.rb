class Planet < ApplicationRecord
	#validates :name, presence: true, length: { maximum: 25 }
	belongs_to :user
	has_many :buildings
end
