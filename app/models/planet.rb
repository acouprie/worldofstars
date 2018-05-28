class Planet < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  belongs_to :user
  has_many :buildings
  accepts_nested_attributes_for :buildings

  STOCK_MINI = 1600
  HOUR = 3600

  def exist?
    Planet
  end

  def create_headquarter
    return unless headquarter.nil?
    Building.create(name: 'Centre de commandement', planet_id: self.id, lvl: 1, conso_power: 0, production: 0, position: 1)
  end

  def create_solar
    return unless solar.nil?
    Building.create_solar(self.id)
  end

  def create_farm
    return unless farm.nil? && (power_conso + 18 < power_stock)
    Building.create_farm(self.id)
  end

  def create_stock_food
    return unless stock_food.nil?
    Building.create(name: 'Entrepôt de nourriture', planet_id: self.id, lvl: 1, conso_power: 0, production: 21000, position: 4)
  end

  def food_production
    return 0 unless farm
    farm.production
  end

  def current_food
    return 0 unless farm
    gap = (Time.now.to_datetime - (self.food_time)&.to_datetime) * 1.days
    total = food_production.to_f / HOUR * gap.to_f
    return STOCK_MINI if total > STOCK_MINI
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
    return 0 unless metal
    gap = (Time.now.to_datetime - (self.metal_time)&.to_datetime) * 1.days
    total = metal_production.to_f / HOUR * gap.to_f
    return STOCK_MINI if total > STOCK_MINI
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
    return 0 unless thorium
    gap = (Time.now.to_datetime - (self.thorium_time)&.to_datetime) * 1.days
    total = metal_production.to_f / HOUR * gap.to_f
    return STOCK_MINI if total > STOCK_MINI
    total.to_i
  end

  def power_production
    return 0 unless solar
    solar.production
  end

  def power_conso
    return 0 unless farm
    farm.conso_power
  end

  def power_stock
    return 0 if solar.nil?
    (solar.production || 0) - (farm&.conso_power || 0)
  end

  private

  def headquarter
    self.buildings.headquarter.first
  end

  def farm
    self.buildings.farm.first
  end

  def solar
    self.buildings.solar.first
  end

  def metal
    self.buildings.metal.first
  end

  def thorium
    self.buildings.thorium.first
  end

  def stock_food
    self.buildings.stock_food.first
  end

  def stock_metal
    self.buildings.stock_metal.first
  end

  def stock_thorium
    self.buildings.stock_thorium.first
  end
end
