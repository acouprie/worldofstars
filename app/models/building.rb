class Building < ApplicationRecord
  belongs_to :planet
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
      when TRAINING_NAME
        TRAINING
      when CAMP_NAME
        CAMP
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

  def image_name
    self.name.downcase.tr(" ", "_").tr("ô", "o").tr("é", "e").tr("'", "_")
  end

  def self.add_buildings_to_planet(planet_id)
    self.create(name: HEADQUARTER_NAME, planet_id: planet_id)
    self.create(name: SOLAR_NAME, planet_id: planet_id)
    self.create(name: FARM_NAME, planet_id: planet_id)
    self.create(name: METAL_NAME, planet_id: planet_id)
    self.create(name: THORIUM_NAME, planet_id: planet_id)
    self.create(name: STOCK_FOOD_NAME, planet_id: planet_id)
    self.create(name: STOCK_METAL_NAME, planet_id: planet_id)
    self.create(name: STOCK_THORIUM_NAME, planet_id: planet_id)
    self.create(name: TRAINING_NAME, planet_id: planet_id)
    self.create(name: CAMP_NAME, planet_id: planet_id)
  end

  def cancel_upgrading
    puts "--- Building " + self.id.to_s + " removed from queue time2build ---"
    Resque.remove_delayed(TimeToBuild, self.id)
    self.update(upgrade_start: nil, conso_power: self.conso_power - conso_power_next_level)
    planet.add_resources_to_total(self)
  end

  def upgrading
    # TODO: enclose with try catch
    puts "--- Building " + self.id.to_s + " in queue time2build ---"
    Resque.enqueue_in_with_queue('time2build', time_to_build, TimeToBuild, self.id)
    self.update(upgrade_start: Time.now, conso_power: conso_power_next_level)
    planet.substract_resources_to_total(self)
  end

  def upgrade
    unless next_level.nil?
      self.update(next_level)
    end
  end

  def check_power_availability
    planet.check_power_availability(conso_power_next_level)
  end

  def check_ressources_availability
    planet.check_ressources_availability(thorium_next_level, metal_next_level, food_next_level)
  end

  # time in seconds
  def time_remaining
    return nil if self.upgrade_start.nil?
    Time.now - (self.upgrade_start + self.time_to_build)
  end

  def finish_at
    return nil if self.upgrade_start.nil?
    self.upgrade_start + self.time_to_build
  end

  private

  def planet
    @planet = Planet.find(self.planet_id)
  end

  def check_uniqueness
    self.name != Building.find_by(name: self.name)
  end
end
