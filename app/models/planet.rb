class Planet < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  belongs_to :user
  has_many :buildings
  accepts_nested_attributes_for :buildings

  def exist?
    Planet
  end

  def add_building_to_planet(type)
    @type = type
    lvl_t = Array[1,2,3,4,5,6,7,8,9]
    record = get_type(@type)
    self.buildings.create(name: record["name"], lvl: lvl_t[0])
    self.add_building_to_place
  end

  def add_building_to_place
    self.place_1 = self.buildings.last.id
  end

  def get_type(type)
    case type
      when '1'
        Hash["name" => "Centre de commandement", "conso" => 0, "prod" => 0, "t2b" => 15]
      when '2'
        Hash["name" => "Champs", "conso" => 18, "prod" => 22, "t2b" => 53]
      when '3'
        Hash["name" => "Mine de métaux", "conso" => 18, "prod" => 22, "t2b" => 45]
      when '4'
        Hash["name" => "Mine de thorium", "conso" => 18, "prod" => 22, "t2b" => 49]
      when '5'
        Hash["name" => "Centrale solaire", "conso" => 0, "prod" => 55, "t2b" => 90]
    end
  end

  def food_stock
      self.get_production("Champs")
      # tot production per seconds
      # self.get_production("Champs") + self.food_tot
  end

  def get_production(n)
    if self.buildings.find_by_name(n) != nil
      self.buildings.find_by_name(n).production
    else
      return 0
    end
  end

  def get_power(n)
    if self.buildings.find_by_name(n) != nil
      self.buildings.find_by_name(n).conso_power
    else
      return 0
    end
  end

  def get_prod_tot_power
    self.get_power("solar")
  end

  def get_conso_tot_power
    center = self.get_power("center")
  	food = self.get_power("food_farm")
  	metal = self.get_power("metal_farm")
  	thorium = self.get_power("thorium_farm")
  	center + food + metal + thorium
  end
end
