class Planet < ApplicationRecord
	validates :name, presence: true, length: { maximum: 25 }
	belongs_to :user
	has_many :buildings
	accepts_nested_attributes_for :buildings

	def add_building_to_planet(type)
      name_type = Hash[1 => "center", 2 => "food_farm", 3 => "metal_farm", 4 => "thorium_farm"]
      conso_type = Hash[1 => 0, 2 => 18, 3 => 18, 4 => 18]
      production_type = Hash[1 => 0, 2 => 22, 3 => 22, 4 => 22]
      self.buildings.create(name: name_type[type], lvl: 1, 
        conso_power: conso_type[type], production: production_type[type])
  end

  def get_production(n)
    if self.buildings.find_by_name(n) != nil
      self.buildings.find_by_name(n).production
    else
      return 0
    end
  end

  def get_conso_power(n)
    if self.buildings.find_by_name(n) != nil
      self.buildings.find_by_name(n).conso_power
    else
      return 0
    end
  end

  def get_conso_tot_power
    center = self.get_conso_power("center")
  	food = self.get_conso_power("food_farm")
  	metal = self.get_conso_power("metal_farm")
  	thorium = self.get_conso_power("thorium_farm")
  	prod_tot = center + food + metal + thorium
  end
end