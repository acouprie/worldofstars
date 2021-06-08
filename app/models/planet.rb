class Planet < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  validates :user_id, presence: true
  belongs_to :user
  has_many :buildings, dependent: :destroy
  has_many :units, dependent: :destroy
  accepts_nested_attributes_for :buildings
  after_create :add_buildings_to_planet, :add_units_to_planet

  include BuildingsHelper
  include UnitsHelper

  STOCK_MINI = 1600
  HOUR = 3600

  def exist?
    Planet
  end

  # to get planets by name
  # /planets/:name
  def to_param
    name
  end

  def define_current_stock(name)
    time = self.send "#{name}_time"
    production = self.send "production", name
    total_stock = self.send "total_#{name}_stock"
    gap = (Time.now.to_datetime - (time)&.to_datetime) * 1.days
    total = production.to_f / HOUR * gap.to_f + total_stock
    total = STOCK_MINI if total > STOCK_MINI
    total.to_i
  end

  def max_stock(name)
    stock = self.send "stock_#{name}"
    return STOCK_MINI if stock.nil? || stock.lvl == 0
    stock.production
  end

  def production(name)
    ressource = self.send "#{name}"
    return 0 unless ressource
    ressource.production
  end

  def power_conso
    total = 0
    self.buildings.each do |building|
      total += building.conso_power
    end
    total
  end

  def power_stock
    return 0 if solar.nil?
    solar.production - power_conso
  end

  def update_stocks
    self.update(
      total_food_stock: define_current_stock('food'),
      food_time: Time.now,
      total_metal_stock: define_current_stock('metal'),
      metal_time: Time.now,
      total_thorium_stock: define_current_stock('thorium'),
      thorium_time: Time.now
      )
  end

  # refund
  def add_resources_to_total(building)
    food = self.total_food_stock + building.next_level.dig(:food_price).to_i
    metal = self.total_metal_stock + building.next_level.dig(:metal_price).to_i
    thorium = self.total_thorium_stock + building.next_level.dig(:thorium_price).to_i
    self.update(total_food_stock: food, food_time: Time.now, total_metal_stock: metal, metal_time: Time.now, total_thorium_stock: thorium, thorium_time: Time.now)
  end

  # pay
  def substract_resources_to_total(building)
    food = self.total_food_stock - building.next_level.dig(:food_price).to_i
    metal = self.total_metal_stock - building.next_level.dig(:metal_price).to_i
    thorium = self.total_thorium_stock - building.next_level.dig(:thorium_price).to_i
    self.update(total_food_stock: food, food_time: Time.now, total_metal_stock: metal, metal_time: Time.now, total_thorium_stock: thorium, thorium_time: Time.now)
  end

  def check_power_availability(conso_power_next_level)
    return true if conso_power_next_level <= self.power_stock
    false
  end

  def check_ressources_availability(thorium_next_level, metal_next_level, food_next_level)
    return false unless (self.define_current_stock('thorium') - thorium_next_level) >= 0 &&
      (self.define_current_stock('metal') - metal_next_level) >= 0 &&
      (self.define_current_stock('food') - food_next_level) >= 0
    true
  end

  def headquarter
    self.buildings.find_by(name: HEADQUARTER_NAME)
  end

  def solar
    self.buildings.find_by(name: SOLAR_NAME)
  end

  def food
    self.buildings.find_by(name: FARM_NAME)
  end

  def metal
    self.buildings.find_by(name: METAL_NAME)
  end

  def thorium
    self.buildings.find_by(name: THORIUM_NAME)
  end

  def stock_food
    self.buildings.find_by(name: STOCK_FOOD_NAME)
  end

  def stock_metal
    self.buildings.find_by(name: STOCK_METAL_NAME)
  end

  def stock_thorium
    self.buildings.find_by(name: STOCK_THORIUM_NAME)
  end

  def training
    self.buildings.find_by(name: STOCK_THORIUM_NAME)
  end

  def camp
    self.buildings.find_by(name: CAMP_NAME)
  end

  private

  def add_buildings_to_planet
    self.buildings.create(name: HEADQUARTER_NAME)
    self.buildings.create(name: SOLAR_NAME)
    self.buildings.create(name: FARM_NAME)
    self.buildings.create(name: METAL_NAME)
    self.buildings.create(name: THORIUM_NAME)
    self.buildings.create(name: STOCK_FOOD_NAME)
    self.buildings.create(name: STOCK_METAL_NAME)
    self.buildings.create(name: STOCK_THORIUM_NAME)
    self.buildings.create(name: TRAINING_NAME)
    self.buildings.create(name: CAMP_NAME)
  end

  def add_units_to_planet
    self.units.create(LIGHT_INFANTRY)
    self.units.create(HEAVY_INFANTRY)
    self.units.create(SCIENTIST)
    self.units.create(ARCHAEOLOGIST)
    self.units.create(SPOT)
    self.units.create(DRONE)
    self.units.create(ATLAS)
    self.units.create(CLONE)
    self.units.create(SUPER_SOLDIER)
  end
end
