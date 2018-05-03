class Building < ApplicationRecord
  before_create :check_uniqueness

  def self.headquarter
    self.where(name: 'Centre de commandement').first
  end

  def self.create_farm(planet_id)
    self.create(name: 'Champs', planet_id: planet_id, lvl: 1, conso_power: 18, production: 100, position: 3)
  end

  def self.farm
    self.where(name: 'Champs').first
  end

  def self.solar
    self.where(name: 'Centrale Solaire').first
  end

  def self.metal
    self.where(name: 'Mine de métaux').first
  end

  def self.thorium
    self.where(name: 'Mine de thorium').first
  end

  def self.stock_food
    self.where(name: 'Entrepôt de nourriture').first
  end

  def check_uniqueness
    self.name != Building.where(name: self.name).first
  end
end
