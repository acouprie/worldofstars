class Building < ApplicationRecord
  before_create :check_uniqueness
  before_save :check_power_availability
  before_save :check_ressources_availability
  validates :planet_id, presence: true

  SOLAR_NAME = 'Centrale Solaire'.freeze
  SOLAR = [
    { lvl: 1, metal_price: 50, food_price: 25, production: 55, time_to_build: 90 },
    { lvl: 2, metal_price: 75, food_price: 37, production: 108, time_to_build: 171 }
  ].freeze

  FARM_NAME = 'Champs'.freeze
  FARM = [
    { lvl: 1, food_price: 50, metal_price: 60, conso_power: 22, production: 18, time_to_build: 53 },
    { lvl: 2, food_price: 75, metal_price: 90, conso_power: 46, production: 21, time_to_build: 95 },
    { lvl: 3, food_price: 112, metal_price: 135, conso_power: 70, production: 51, time_to_build: 170 },
    { lvl: 4, food_price: 168, metal_price: 202, conso_power: 94, production: 93, time_to_build: 306 },
    { lvl: 5, food_price: 253, metal_price: 303, conso_power: 118, production: 149, time_to_build: 551 },
    { lvl: 6, food_price: 379, metal_price: 405, conso_power: 142, production: 223, time_to_build: 992 },
    { lvl: 7, food_price: 569, metal_price: 683, conso_power: 166, production: 322, time_to_build: 1785 },
    { lvl: 8, food_price: 854, metal_price: 1025, conso_power: 190, production: 451, time_to_build: 3214 },
    { lvl: 9, food_price: 1281, metal_price: 1537, conso_power: 214, production: 619, time_to_build: 5785 },
    { lvl: 10, food_price: 1922, metal_price: 2306, conso_power: 238, production: 835, time_to_build: 10414 },
    { lvl: 11, food_price: 2883, metal_price: 3459, conso_power: 262, production: 1114, time_to_build: 18745 },
    { lvl: 12, food_price: 4324, metal_price: 5189, conso_power: 286, production: 1471, time_to_build: 33740 },
    { lvl: 13, food_price: 6487, metal_price: 7784, conso_power: 310, production: 1925, time_to_build: 60734 },
    { lvl: 14, food_price: 9730, metal_price: 11677, conso_power: 334, production: 2503, time_to_build: 109320 },
    { lvl: 15, food_price: 14596, metal_price: 17515, conso_power: 358, production: 3235, time_to_build: 196777 },
    { lvl: 16, food_price: 21894, metal_price: 26273, conso_power: 382, production: 4159, time_to_build: 354198 },
    { lvl: 17, food_price: 32842, metal_price: 45978, conso_power: 406, production: 5324, time_to_build: 637557 },
    { lvl: 18, food_price: 49263, metal_price: 68968, conso_power: 430, production: 6788, time_to_build: 1147604 },
    { lvl: 19, food_price: 73894, metal_price: 88673, conso_power: 454, production: 8625, time_to_build: 2065686 },
    { lvl: 20, food_price: 110841, metal_price: 133010, conso_power: 478, production: 10926, time_to_build: 3718235 }
  ].freeze

  # TODO update time to build
  METAL_NAME = 'Mine de métaux'.freeze
  METAL = [
    { lvl: 1, food_price: 20, metal_price: 60, conso_power: 11, production: 24, time_to_build: 45 },
    { lvl: 2, food_price: 30, metal_price: 105, conso_power: 46, production: 57, time_to_build: 45 },
    { lvl: 3, food_price: 45, metal_price: 157, conso_power: 70, production: 103, time_to_build: 45 },
    { lvl: 4, food_price: 67, metal_price: 236, conso_power: 94, production: 165, time_to_build: 45 },
    { lvl: 5, food_price: 101, metal_price: 354, conso_power: 118, production: 248, time_to_build: 45 },
    { lvl: 6, food_price: 151, metal_price: 531, conso_power: 142, production: 358, time_to_build: 45 },
    { lvl: 7, food_price: 227, metal_price: 797, conso_power: 16, production: 501, time_to_build: 45 },
    { lvl: 8, food_price: 341, metal_price: 1196, conso_power: 190, production: 687, time_to_build: 45 },
    { lvl: 9, food_price: 512, metal_price: 1794, conso_power: 214, production: 928, time_to_build: 45 },
    { lvl: 10, food_price: 768, metal_price: 2691, conso_power: 238, production: 1238, time_to_build: 45 },
    { lvl: 11, food_price: 1153, metal_price: 4036, conso_power: 262, production: 1634, time_to_build: 45 },
    { lvl: 12, food_price: 1729, metal_price: 6054, conso_power: 286, production: 2139, time_to_build: 45 },
    { lvl: 13, food_price: 2594, metal_price: 9082, conso_power: 310, production: 2781, time_to_build: 45 },
    { lvl: 14, food_price: 3892, metal_price: 13623, conso_power: 334, production: 3594, time_to_build: 45 },
    { lvl: 15, food_price: 5838, metal_price: 20435, conso_power: 358, production: 4622, time_to_build: 45 },
    { lvl: 16, food_price: 8757, metal_price: 30652, conso_power: 382, production: 5916, time_to_build: 45 },
    { lvl: 17, food_price: 13136, metal_price: 45978, conso_power: 406, production: 7543, time_to_build: 45 },
    { lvl: 18, food_price: 19705, metal_price: 68968, conso_power: 430, production: 9584, time_to_build: 45 },
    { lvl: 19, food_price: 29557, metal_price: 103452, conso_power: 454, production: 12140, time_to_build: 45 },
    { lvl: 20, food_price: 44336, metal_price: 155178, conso_power: 478, production: 15355, time_to_build: 45 }
  ]

  THORIUM_NAME = 'Mine de thorium'.freeze
  THORIUM = [
    { lvl: 1, metal_price: 50, food_price: 40, conso_power: 22, production: 18, time_to_build: 53 },
    { lvl: 2, metal_price: 75, food_price: 60, conso_power: 46, production: 43, time_to_build: 95 },
    { lvl: 3, metal_price: 112, food_price: 90, conso_power: 70, production: 77, time_to_build: 170 },
    { lvl: 4, metal_price: 168, food_price: 135, conso_power: 94, production: 124, time_to_build: 306 },
    { lvl: 5, metal_price: 253, food_price: 202, conso_power: 118, production: 186, time_to_build: 551 },
    { lvl: 6, metal_price: 379, food_price: 303, conso_power: 142, production: 268, time_to_build: 992 },
    { lvl: 7, metal_price: 569, food_price: 455, conso_power: 166, production: 376, time_to_build: 1785 },
    { lvl: 8, metal_price: 854, food_price: 683, conso_power: 190, production: 515, time_to_build: 3214 },
    { lvl: 9, metal_price: 1281, food_price: 1025, conso_power: 214, production: 696, time_to_build: 5785 },
    { lvl: 10, metal_price: 1922, food_price: 1537, conso_power: 238, production: 928, time_to_build: 10414 },
    { lvl: 11, metal_price: 2883, food_price: 2306, conso_power: 262, production: 1225, time_to_build: 18745 },
    { lvl: 12, metal_price: 4324, food_price: 3459, conso_power: 286, production: 1604, time_to_build: 33740 },
    { lvl: 13, metal_price: 6487, food_price: 5189, conso_power: 310, production: 2086, time_to_build: 60734 },
    { lvl: 14, metal_price: 9730, food_price: 7784, conso_power: 334, production: 2696, time_to_build: 109320 },
    { lvl: 15, metal_price: 14596, food_price: 11677, conso_power: 358, production: 3466, time_to_build: 196777 },
    { lvl: 16, metal_price: 21894, food_price: 17515, conso_power: 382, production: 4437, time_to_build: 354198 },
    { lvl: 17, metal_price: 32842, food_price: 26273, conso_power: 406, production: 5657, time_to_build: 637557 },
    { lvl: 18, metal_price: 49263, food_price: 39410, conso_power: 430, production: 7188, time_to_build: 1147604 },
    { lvl: 19, metal_price: 73894, food_price: 59115, conso_power: 454, production: 9105, time_to_build: 2065686 },
    { lvl: 20, metal_price: 110841, food_price: 88673, conso_power: 478, production: 11501, time_to_build: 3718235 }
  ].freeze

  HEADQUARTER_NAME = 'Centre de commandement'.freeze
  HEADQUARTER = [
    { lvl: 1, metal_price: 600, food_price: 150, thorium_price: 300, time_to_build: 15 },
    { lvl: 2, metal_price: 1260, food_price: 315, thorium_price: 630, time_to_build: 15 },
    { lvl: 3, metal_price: 2646, food_price: 661, thorium_price: 1323, time_to_build: 15 },
    { lvl: 4, metal_price: 5556, food_price: 1389, thorium_price: 2778, time_to_build: 15 },
    { lvl: 5, metal_price: 11668, food_price: 2917, thorium_price: 5834, time_to_build: 15 },
    { lvl: 6, metal_price: 24504, food_price: 6126, thorium_price: 12252, time_to_build: 15 },
    { lvl: 7, metal_price: 51549, food_price: 12864, thorium_price: 25729, time_to_build: 15 },
    { lvl: 8, metal_price: 108865, food_price: 27016, thorium_price: 54032, time_to_build: 15 },
    { lvl: 9, metal_price: 226937, food_price: 56734, thorium_price: 113468, time_to_build: 15 },
    { lvl: 10, metal_price: 476568, food_price: 119142, thorium_price: 238284, time_to_build: 15 },
    { lvl: 11, metal_price: 1000792, food_price: 250168, thorium_price: 500396, time_to_build: 15 },
    { lvl: 12, metal_price: 2101665, food_price: 525416, thorium_price: 1050832, time_to_build: 15 },
    { lvl: 13, metal_price: 4413496, food_price: 1103374, thorium_price: 2206748, time_to_build: 15 }
  ].freeze

  STOCK_FOOD_NAME = 'Entrepôt de nourriture'.freeze
  STOCK_FOOD = [

  ].freeze

  STOCK_METAL_NAME = 'Entrepôt de metal'.freeze
  STOCK_METAL = [

  ].freeze

  STOCK_THORIUM_NAME = 'Entrepôt de thorium'.freeze
  STOCK_THORIUM = [

  ].freeze

  def planet
    @planet = Planet.find(self.planet_id)
  end

  def define_type
    case self.name
      when HEADQUARTER_NAME
        HEADQUARTER
      when SOLAR_NAME
        SOLAR
      when FARM_NAME
        FARM
      when METAL_NAME
        METAL
      when THORIUM_NAME
        THORIUM
      when STOCK_FOOD_NAME
        STOCK_FOOD
      when STOCK_THORIUM_NAME
        STOCK_THORIUM
      when STOCK_METAL_NAME
        STOCK_METAL
    end
  end

  def self.headquarter
    self.find_by(name: HEADQUARTER_NAME)
  end

  def self.solar
    self.find_by(name: SOLAR_NAME)
  end

  def self.farm
    self.find_by(name: FARM_NAME)
  end

  def self.metal
    self.find_by(name: METAL_NAME)
  end

  def self.thorium
    self.find_by(name: THORIUM_NAME)
  end

  def self.stock_food
    self.find_by(name: STOCK_FOOD_NAME)
  end

  def self.stock_metal
    self.find_by(name: STOCK_METAL_NAME)
  end

  def self.stock_thorium
    self.find_by(name: STOCK_THORIUM_NAME)
  end

  def next_level
    define_type[self.lvl]
  end

  def time_to_build
    next_level&.dig(:time_to_build).to_i
  end

  def conso_power_next_level
    next_level&.dig(:conso_power).to_i ||= 0
  end

  def production_next_level
    next_level&.dig(:production).to_i ||= 0
  end

  def thorium_next_level
    next_level&.dig(:thorium_price).to_i
  end

  def metal_next_level
    next_level&.dig(:metal_price).to_i
  end

  def food_next_level
    next_level&.dig(:food_price).to_i
  end

  def self.add_buildings_to_planet(planet_id)
    self.create(name: HEADQUARTER_NAME, planet_id: planet_id)
    self.create(name: SOLAR_NAME, planet_id: planet_id)
    self.create(name: FARM_NAME, planet_id: planet_id)
    self.create(name: METAL_NAME, planet_id: planet_id)
    self.create(name: THORIUM_NAME, planet_id: planet_id)
  end

  def async_update_building
    return unless check_ressources_availability && check_power_availability
    self.substract_ressources_to_total
    Resque.enqueue_in_with_queue('time2build', time_to_build, TimeToBuild, self.id)
  end

  def upgrade
    return unless check_ressources_availability && check_power_availability
    unless next_level.nil?
      self.update(next_level)
    end
  end

  def substract_ressources_to_total
    food = planet.total_food_stock - food_next_level
    metal = planet.total_metal_stock - metal_next_level
    thorium = planet.total_thorium_stock - thorium_next_level
    planet.update(total_food_stock: food, food_time: Time.now, total_metal_stock: metal, metal_time: Time.now, total_thorium_stock: thorium, thorium_time: Time.now)
  end

  def check_power_availability
    return true if planet.power_conso + conso_power_next_level <= planet.power_stock
    false
  end

  def check_ressources_availability
    return false unless (planet.current_thorium - thorium_next_level) > 0 &&
      (planet.current_metal - metal_next_level) > 0 &&
      (planet.current_food - food_next_level) > 0
    true
  end

  private

  def check_uniqueness
    self.name != Building.find_by(name: self.name)
  end
end
