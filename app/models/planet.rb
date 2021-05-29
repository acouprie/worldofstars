class Planet < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  validates :user_id, presence: true
  belongs_to :user
  has_many :buildings
  accepts_nested_attributes_for :buildings
  after_create :add_buildings_to_planet

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
    food = self.total_food_stock + building.food_next_level
    metal = self.total_metal_stock + building.metal_next_level
    thorium = self.total_thorium_stock + building.thorium_next_level
    self.update(total_food_stock: food, food_time: Time.now, total_metal_stock: metal, metal_time: Time.now, total_thorium_stock: thorium, thorium_time: Time.now)
  end

  # pay
  def substract_resources_to_total(building)
    food = self.total_food_stock - building.food_next_level
    metal = self.total_metal_stock - building.metal_next_level
    thorium = self.total_thorium_stock - building.thorium_next_level
    self.update(total_food_stock: food, food_time: Time.now, total_metal_stock: metal, metal_time: Time.now, total_thorium_stock: thorium, thorium_time: Time.now)
  end

  def check_power_availability(conso_power_next_level)
    return true if conso_power_next_level <= self.power_stock
    false
  end

  def check_ressources_availability(thorium_next_level, metal_next_level, food_next_level)
    return false unless (self.define_current_stock('thorium') - thorium_next_level) > 0 &&
      (self.define_current_stock('metal') - metal_next_level) > 0 &&
      (self.define_current_stock('food') - food_next_level) > 0
    true
  end

  def headquarter
    self.buildings.headquarter
  end

  def food
    self.buildings.farm
  end

  def solar
    self.buildings.solar
  end

  def metal
    self.buildings.metal
  end

  def thorium
    self.buildings.thorium
  end

  def stock_food
    self.buildings.stock_food
  end

  def stock_metal
    self.buildings.stock_metal
  end

  def stock_thorium
    self.buildings.stock_thorium
  end

  private

  def add_buildings_to_planet
    Building.add_buildings_to_planet(self.id)
  end
end
