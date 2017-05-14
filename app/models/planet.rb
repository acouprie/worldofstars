class Planet < ApplicationRecord
	validates :name, presence: true, length: { maximum: 25 }
	belongs_to :user
	has_many :buildings
	accepts_nested_attributes_for :buildings

  def exist?
    Planet.all.find(self)
  end

	def add_building_to_planet(type)
    lvl_t = Array[1,2,3,4,5,6,7,8,9]
      record = get_type(type)
      self.waiter(record["t2b"])
      self.buildings.create(name: record["name"], lvl: lvl_t[0], conso_power: 
        record["conso"], production: record["prod"])
      self.add_building_to_place
      return record["t2b"]
  end

  def add_building_to_place
    self.place_1 = self.buildings.last.id
  end

  def waiter(t)
    Thread.new {
      # wait x seconds
      @i = 0
      @sec_left = t
      while @i < t
        sleep 1
        @i = @i + 1
        @sec_left = @sec_left - 1
        puts @sec_left
      end
    }
  end

  def get_type(type)
  
    case type
      when 1
        center = Hash["name" => "Centre de commandement", "conso" => 0, "prod" => 0, "t2b" => 15]
        record = center
      when 2
        food_farm = Hash["name" => "Champs", "conso" => 18, "prod" => 22, "t2b" => 53]
        record = food_farm
      when 3
        metal_farm = Hash["name" => "Mine de métaux", "conso" => 18, "prod" => 22, "t2b" => 45]
        record = metal_farm
      when 4
        thorium_farm = Hash["name" => "Mine de thorium", "conso" => 18, "prod" => 22, "t2b" => 49]
        record = thorium_farm
      when 5
        solar = Hash["name" => "Centrale solaire", "conso" => 0, "prod" => 55, "t2b" => 90]
        record = solar
    end
    return record
  end

  def food_stock
    Thread.new {
      $food = 0
      $prod_per_hour = self.get_production("Champs")
      $prod_per_second = $prod_per_hour / 60
      $max = 1600
      until $food > $max  do
         $food+=$prod_per_second
      end
      # tot production per seconds
      # self.get_production("Champs") + self.food_tot
    }
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
    solar = self.get_power("solar")
  end

  def get_conso_tot_power
    center = self.get_power("center")
  	food = self.get_power("food_farm")
  	metal = self.get_power("metal_farm")
  	thorium = self.get_power("thorium_farm")
  	prod_tot = center + food + metal + thorium
  end
end