class Unit < ApplicationRecord
  belongs_to :planet
  validates :planet_id, presence: true
end
