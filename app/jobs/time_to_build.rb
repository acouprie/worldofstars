module TimeToBuild
  @queue = :time2build

  def self.perform(id)
    building = Building.find(id)
    building.upgrade
    puts "--- building upgraded ---"
  end
end
