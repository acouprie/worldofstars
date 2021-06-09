class Unit < ApplicationRecord
  belongs_to :planet
  validates :planet_id, presence: true

  def image_name
    self.name.downcase.tr(" ", "_").tr("ô", "o").tr("é", "e").tr("è", "e").tr("'", "_")
  end

  def training
    # TODO: enclose with try catch
    puts "--- Unit " + self.id.to_s + " " + self.name + " in queue unit for " + self.time_to_build.to_s + "s ---"
    Resque.enqueue_in_with_queue('unitTrain', self.time_to_build, UnitTrain, self.id)
    # self.update(upgrade_start: Time.now, conso_power: next_level.dig(:conso_power).to_i ||= 0)
    planet.substract_resources_to_total(self)
  end

  def train
    nb = self.number + 1
    self.update(number: nb)
  end
end
