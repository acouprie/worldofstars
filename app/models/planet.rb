require 'buildings/farm.rb'
require 'buildings/solar.rb'

class Planet < ApplicationRecord
  validates :name, presence: true, length: { maximum: 25 }
  belongs_to :user
  has_one :farm
  has_one :solar
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

  def create_solar
    Solar.create(name: 'Centrale Solaire', planet_id: self.id, lvl: 1, conso_power: 0, production: 55)
  end

  def create_farm
    Farm.create(name: 'Champs', planet_id: self.id, lvl: 1, conso_power: 18, production: 100)
  end

  def food_production
    return 0 unless self.farm
    self.farm[:production]
  end

  def food_stock
    return 0 unless self.farm
    #$redis.set("#{self.id}-food", 0)
    #$redis.set("#{self.id}-food-time", Time.now.to_datetime)
    stock_saved = ($redis.get("#{self.id}-food")).to_i
    gap = (Time.now.to_datetime - ($redis.get("#{self.id}-food-time"))&.to_datetime) * 1.days
    prod = food_production.to_f / 3600 * gap.to_f
    stock_saved + prod
  end

  def get_production
    puts self.inspect
    #$redis.set("foo", "bar")
  end

  def prod_power
    return 0 unless self.solar
    self.solar[:production]
  end

  def conso_power
    return 0 unless self.farm
    self.farm[:conso_power]
  end
end
