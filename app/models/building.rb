class Building < ApplicationRecord
  def self.headquarter
    self.where(name: 'Centre de commandement').first
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
end
