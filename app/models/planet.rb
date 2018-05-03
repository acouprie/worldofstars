class Planet < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  belongs_to :user
  has_many :buildings
  accepts_nested_attributes_for :buildings

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
    Building.create(name: 'Champs', planet_id: self.id, lvl: 1, conso_power: 18, production: 100, position: 3)
  end

  def food_production
    return 0 unless self.buildings.farm
    self.buildings.farm.production
  end

  def food_stock
    #$redis.set("#{self.id}-food", 0)
    #$redis.set("#{self.id}-food-time", Time.now.to_datetime)
    return 0 unless self.buildings.farm
    stock_saved = ($redis.get("#{self.id}-food")).to_i
    gap = (Time.now.to_datetime - ($redis.get("#{self.id}-food-time"))&.to_datetime) * 1.days
    prod = food_production.to_f / 3600 * gap.to_f
    stock_saved + prod
  end

  def metal_production
    return 0 unless self.buildings.metal
    self.buildings.metal.production
  end

  def metal_stock
    return 0 unless self.buildings.metal
    stock_saved = ($redis.get("#{self.id}-metal")).to_i
    gap = (Time.now.to_datetime - ($redis.get("#{self.id}-metal-time"))&.to_datetime) * 1.days
    prod = metal_production.to_f / 3600 * gap.to_f
    stock_saved + prod
  end

  def thorium_production
    return 0 unless self.buildings.metal
    self.buildings.metal.production
  end

  def thorium_stock
    return 0 unless self.buildings.metal
    #$redis.set("#{self.id}-thorium", 0)
    #$redis.set("#{self.id}-thorium-time", Time.now.to_datetime)
    stock_saved = ($redis.get("#{self.id}-thorium")).to_i
    gap = (Time.now.to_datetime - ($redis.get("#{self.id}-thorium-time"))&.to_datetime) * 1.days
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
