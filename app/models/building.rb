class Building < ApplicationRecord
  before_create :check_uniqueness

  def self.create_headquarter(planet_id)
    self.create(name: 'Centre de commandement', planet_id: planet_id, lvl: 1, conso_power: 0, production: 0, position: 1) # t2b = 15
  end

  def self.create_solar(planet_id)
    self.create(name: 'Centrale Solaire', planet_id: planet_id, lvl: 1, conso_power: 0, production: 55, position: 2) # t2b = 90
  end

  def self.create_farm(planet_id)
    self.create(name: 'Champs', planet_id: planet_id, lvl: 1, conso_power: 18, production: 22, position: 3) # t2b = 53
  end

  def self.create_metal(planet_id)
    self.create(name: 'Mine de métaux', planet_id: planet_id, lvl: 1, conso_power: 18, production: 22, position: 4) # t2b = 45
  end

  def self.create_thorium(planet_id)
    self.create(name: 'Mine de thorium', planet_id: planet_id, lvl: 1, conso_power: 18, production: 22, position: 5) # t2b = 49
  end

  def self.headquarter
    self.where(name: 'Centre de commandement')
  end

  def self.solar
    self.where(name: 'Centrale Solaire')
  end

  def self.farm
    self.where(name: 'Champs')
  end

  def self.metal
    self.where(name: 'Mine de métaux')
  end

  def self.thorium
    self.where(name: 'Mine de thorium')
  end

  def self.stock_food
    self.where(name: 'Entrepôt de nourriture')
  end

  def self.stock_metal
    self.where(name: 'Entrepôt de métaux')
  end

  def self.stock_thorium
    self.where(name: 'Entrepôt de thorium')
  end

  private

  def check_uniqueness
    self.name != Building.where(name: self.name).first
  end
end
