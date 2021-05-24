class Building < ApplicationRecord
  before_create :check_uniqueness
  before_save :check_power_availability
  before_save :check_ressources_availability
  validates :planet_id, presence: true

  include BuildingsHelper

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

  def upgrade_building(id)
    building = Building.find_by(id: id)
    building.async_update_building
    building.update(upgrade_start: Time.now, conso_power: conso_power_next_level)
    self.substract_ressources_to_total
    return building
  end

  def async_update_building
    # TODO: enclose with try catch
    puts "--- Building " + self.id.to_s + " in queue time2build ---"
    Resque.enqueue_in_with_queue('time2build', time_to_build, TimeToBuild, self.id)
  end

  def upgrade
    unless next_level.nil?
      self.update(next_level)
    end
  end

  # TODO: this shall be planet model responsibility
  def substract_ressources_to_total
    food = planet.total_food_stock - food_next_level
    metal = planet.total_metal_stock - metal_next_level
    thorium = planet.total_thorium_stock - thorium_next_level
    planet.update(total_food_stock: food, food_time: Time.now, total_metal_stock: metal, metal_time: Time.now, total_thorium_stock: thorium, thorium_time: Time.now)
  end

  def check_power_availability
    return true if conso_power_next_level <= planet.power_stock
    false
  end

  def check_ressources_availability
    return false unless (planet.define_current_stock('thorium') - thorium_next_level) > 0 &&
      (planet.define_current_stock('metal') - metal_next_level) > 0 &&
      (planet.define_current_stock('food') - food_next_level) > 0
    true
  end

  private

  def planet
    @planet = Planet.find(self.planet_id)
  end

  def check_uniqueness
    self.name != Building.find_by(name: self.name)
  end
end
