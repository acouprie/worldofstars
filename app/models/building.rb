class Building < ApplicationRecord
  belongs_to :planet
  before_create :check_uniqueness
  before_save :check_power_availability
  before_save :check_ressources_availability
  validates :planet_id, presence: true

  include BuildingsHelper

  def define_type
    case self.name
      when HEADQUARTER_NAME
        HEADQUARTER
      when SOLAR_NAME
        SOLAR
      when FARM_NAME
        FARM
      when METAL_NAME
        METAL
      when THORIUM_NAME
        THORIUM
      when STOCK_FOOD_NAME
        STOCK_FOOD
      when STOCK_THORIUM_NAME
        STOCK_THORIUM
      when STOCK_METAL_NAME
        STOCK_METAL
      when TRAIN_CAMP_NAME
        TRAIN_CAMP
      when CAMP_NAME
        CAMP
    end
  end

  def next_level
    define_type[self.lvl]
  end

  def image_name
    self.name.downcase.tr(" ", "_").tr("ô", "o").tr("é", "e").tr("'", "_")
  end

  def set_position(position)
    return if self.lvl != 0
    self.update(position: position)
  end

  def cancel_upgrading
    puts "--- Building " + self.id.to_s + " removed from queue buildingUpgrade ---"
    Resque.remove_delayed(BuildingUpgrade, self.id)
    self.update(upgrade_start: nil, conso_power: self.conso_power - next_level.dig(:conso_power).to_i ||= 0)
    planet.add_resources_to_total(self)
    self.set_position(nil) if self.lvl == 0
  end

  def upgrading
    # TODO: enclose with try catch
    puts "--- Building " + self.id.to_s + " in queue buildingUpgrade ---"
    Resque.enqueue_in_with_queue('buildingUpgrade', next_level.dig(:time_to_build).to_i, BuildingUpgrade, self.id)
    self.update(upgrade_start: Time.now, conso_power: next_level.dig(:conso_power).to_i ||= 0)
    planet.substract_resources_to_total(self)
  end

  def upgrade
    unless next_level.nil? || self.position.nil?
      self.update(next_level)
    end
    self.update(upgrade_start: nil)
  end

  def check_power_availability
    planet.check_power_availability(next_level.dig(:conso_power).to_i ||= 0)
  end

  def check_ressources_availability
    planet.check_ressources_availability(next_level.dig(:thorium_price).to_i, next_level.dig(:metal_price).to_i, next_level.dig(:food_price).to_i)
  end

  # time in seconds
  def time_remaining
    return nil if self.upgrade_start.nil?
    Time.now - (self.upgrade_start + self.next_level.dig(:time_to_build).to_i)
  end

  def finish_at
    return nil if self.upgrade_start.nil?
    self.upgrade_start + self.next_level.dig(:time_to_build).to_i
  end

  def hasDependencies
    flash_message = nil
    # headquarter must be first
    if planet.headquarter.lvl == 0 && planet.headquarter != self
      flash_message = "Améliorez d'abord le Centre de commandemant !"
    # solar must be second
    elsif planet.solar.lvl == 0 && planet.solar != self && planet.headquarter != self
      flash_message = "Améliorez d'abord la centrale solaire !"
    # production site must be third
    elsif planet.headquarter != self &&
      planet.solar != self &&
      planet.food != self &&
      planet.metal != self &&
      planet.thorium != self &&
      (planet.food.lvl == 0 || planet.metal.lvl == 0 || planet.thorium.lvl == 0)
      flash_message = "Améliorez d'abord les sites de production !"
    # stock and CELAE needs headquarter lvl 2
    elsif (planet.stock_food == self || planet.stock_metal == self || planet.stock_thorium == self) &&
      planet.headquarter.lvl < 2
      flash_message = "Améliorez d'abord le Centre de commandemant !"
    # laboratory and taining camp needs headquarter lvl 4
    elsif planet.train_camp == self && planet.headquarter < 4
      flash_message = "Améliorez d'abord le Centre de commandemant !"
    # wormhole needs headquarter lvl 5, laboratory lvl 3, CELAE 1
    # Camp militaire => Prérequis :  centre de commandement  lvl 5; camp d'entrainement  lvl 2 ; laboratoire  lvl 2
    # Fusion Nucléaire => Prérequis : Centre de commandement lvl 5 ; Centrale électrique lvl 10 ;  Laboratoire  lvl  5 ; Maitrise de l'énergie lvl 7
    # Tunnel Tok'ra => prérequis  : centre de  commandement  lvl 7 ; laboratoir lvl 7 ; technologie cristaux lvl 10
    # Usine spatial => Prérequis  : centre de commandement  lvl 5,  laboratoire  lvl 8
    # Satellite Radar => Prérequis : centre de commandement  lvl 8 ;  laboratoire lvl 8 ; usine spatial  lvl 5 ; exploration lvl 7
    end
    return flash_message.nil? ? false : flash_message
  end

  private

  def planet
    @planet = Planet.find(self.planet_id)
  end

  def check_uniqueness
    self.name != Building.find_by(name: self.name)
  end
end
