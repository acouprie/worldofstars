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

  def upgrade_building(id)
    building = self.buildings.find_by(id: id)
    building.async_update_building
  end

  def food_production
    return 0 unless farm
    farm.production
  end

  def current_food
    gap = (Time.now.to_datetime - (self.food_time)&.to_datetime) * 1.days
    total = food_production.to_f / HOUR * gap.to_f + self.total_food_stock
    total = STOCK_MINI if total > STOCK_MINI
    total.to_i
  end

  def food_stock
    return STOCK_MINI if stock_food.nil?
    stock_food.production
  end

  def metal_production
    return 0 unless metal
    metal.production
  end

  def metal_stock
    return STOCK_MINI if stock_metal.nil?
    stock_metal.production
  end

  def current_metal
    gap = (Time.now.to_datetime - (self.metal_time)&.to_datetime) * 1.days
    total = metal_production.to_f / HOUR * gap.to_f + self.total_metal_stock
    total = STOCK_MINI if total > STOCK_MINI
    total.to_i
  end

  def thorium_production
    return 0 unless thorium
    thorium.production
  end

  def thorium_stock
    return STOCK_MINI if stock_thorium.nil?
    stock_thorium.production
  end

  def current_thorium
    gap = (Time.now.to_datetime - (self.thorium_time)&.to_datetime) * 1.days
    total = thorium_production.to_f / HOUR * gap.to_f + self.total_thorium_stock
    total = STOCK_MINI if total > STOCK_MINI
    total.to_i
  end

  def power_production
    return 0 unless solar
    solar.production
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
    self.update(total_food_stock: current_food, food_time: Time.now, total_metal_stock: current_metal, metal_time: Time.now, total_thorium_stock: current_thorium, thorium_time: Time.now)
  end

  private

  def headquarter
    self.buildings.headquarter
  end

  def farm
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

  def add_buildings_to_planet
    Building.add_buildings_to_planet(self.id)
  end
end
