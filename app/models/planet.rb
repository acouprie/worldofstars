class Planet < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  belongs_to :user
  has_many :buildings
  accepts_nested_attributes_for :buildings

  STOCK_MINI = 1600

  def farm
    self.buildings.farm
  end

  def exist?
    Planet
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

  def create_headquarter
    return unless self.buildings.headquarter.nil?
    Building.create(name: 'Centre de commandement', planet_id: self.id, lvl: 1, conso_power: 0, production: 0, position: 1)
  end

  def create_solar
    return unless self.buildings.solar.nil?
    Building.create(name: 'Centrale Solaire', planet_id: self.id, lvl: 1, conso_power: 0, production: 55, position: 2)
  end

  def create_farm
    return unless self.buildings.farm.nil?
    Building.create_farm(self.id)
  end

  def create_stock_food
    return unless self.buildings.stock_food.nil?
    Building.create(name: 'Entrepôt de nourriture', planet_id: self.id, lvl: 1, conso_power: 0, production: 21000, position: 4)
  end

  def food_production
    return 0 unless farm
    farm.production
  end

  def current_food
    return 0 unless self.buildings.farm
    stock_saved = self.food_stock
    gap = (Time.now.to_datetime - (self.food_time)&.to_datetime) * 1.days
    prod = food_production.to_f / 3600 * gap.to_f
    total = stock_saved + prod
    return STOCK_MINI if total > STOCK_MINI
    total.to_i
  end

  def max_food
    return 1600 if self.buildings.stock_food.nil?
    self.buildings.stock_food.production
  end

  def metal_production
    return 0 unless self.buildings.metal
    self.buildings.metal.production
  end

  def metal_stock
    return 0 unless self.buildings.metal
    stock_saved = self.metal_stock
    gap = (Time.now.to_datetime - (self.metal_time)&.to_datetime) * 1.days
    prod = metal_production.to_f / 3600 * gap.to_f
    stock_saved + prod
  end

  def thorium_production
    return 0 unless self.buildings.metal
    self.buildings.metal.production
  end

  def thorium_stock
    return 0 unless self.buildings.metal
    stock_saved = self.thorium_stock
    gap = (Time.now.to_datetime - (self.thorium_time)&.to_datetime) * 1.days
    prod = metal_production.to_f / 3600 * gap.to_f
    stock_saved + prod
  end

  def power_production
    return 0 unless self.buildings.solar
    self.buildings.solar.production
  end

  def power_conso
    return 0 unless self.buildings.farm
    self.buildings.farm.conso_power
  end

  def power_stock
    return 0 if self.buildings.empty?
    (self.buildings.solar&.production || 0) - (self.buildings.farm&.conso_power || 0)
  end
end
