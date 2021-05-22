module TimeToBuild
  @queue = :time2build

  def self.perform(id)
    building = Building.find(id)
    if building.upgrade
      puts "--- building upgraded for id: #{id} ---"
      building.update(upgrade_start: nil)
    else
      puts "--- building upgrade failed for id: #{id} ---"
    end
  end
end
