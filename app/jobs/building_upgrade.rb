module BuildingUpgrade
  @queue = :buildingUpgrade

  def self.perform(id)
    building = Building.find(id)
    if building.upgrade
      puts "--- building upgraded for id: #{id} ---"
    else
      puts "--- building upgrade failed for id: #{id} ---"
    end
  end
end
