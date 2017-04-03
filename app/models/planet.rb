class Planet < ApplicationRecord
	validates :name, presence: true, length: { maximum: 25 }
	after_create :add_building_to_planet
	belongs_to :user
	has_many :buildings
	accepts_nested_attributes_for :buildings
	def add_building_to_planet
 		self.buildings.create(name:"center", lvl: 1, conso_power: 0, production: 0)
 		self.buildings.create(name:"food_farm", lvl: 1, conso_power: 22, production: 18)
 		self.buildings.create(name:"metal_farm", lvl: 1, conso_power: 22, production: 18)
 		self.buildings.create(name:"thorium_farm", lvl: 1, conso_power: 22, production: 18)
 	end
  def get_production(planet, name)
    planet.buildings.where(planet_id:planet.id, name:name).first.production
  end
  def get_conso_tot_power
  	food = self.buildings.find_by_name("food_farm").production
  	metal = self.buildings.find_by_name("metal_farm").production
  	thorium = self.buildings.find_by_name("thorium_farm").production
  	prod_tot = food + metal + thorium
  end
end