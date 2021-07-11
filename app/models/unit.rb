class Unit < ApplicationRecord
  belongs_to :planet
  validates :planet_id, presence: true

  def image_name
    self.name.downcase.tr(" ", "_").tr("ô", "o").tr("é", "e").tr("è", "e").tr("'", "_")
  end

  def isTrainable
    t_lvl = self.planet.train_camp.lvl
    planet_units = self.planet.units.sort

    if t_lvl == 0 || (t_lvl > 0 && planet_units[0] != self) ||
      (t_lvl > 2 && !planet_units[..1].include?(self)) ||
      (t_lvl > 4 && !planet_units[4].include?(self)) ||
      (t_lvl > 5 && ![planet_units[2], planet_units[5]].include?(self)) ||
      (t_lvl > 8 && !planet_units[5..].include?(self))
      return false
    end
    true
  end

  def training(nb_unit)
    # TODO: enclose with try catch
    nb_unit.times { |i|
      unit_t2b = self.time_to_build * i + 1
      puts "--- Unit " + self.id.to_s + " " + self.name + " in queue unit for " + unit_t2b.to_s + "s ---"
      Resque.enqueue_in_with_queue('unitTrain', unit_t2b, UnitTrain, self.id)
    }
    planet.substract_resources_to_total(self)
  end

  def train
    nb = self.number + 1
    self.update(number: nb)
  end
end
