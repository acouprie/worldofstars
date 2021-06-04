class Unit < ApplicationRecord
  belongs_to :planet
  validates :planet_id, presence: true

  def image_name
    self.name.downcase.tr(" ", "_").tr("ô", "o").tr("é", "e").tr("è", "e").tr("'", "_")
  end
end
