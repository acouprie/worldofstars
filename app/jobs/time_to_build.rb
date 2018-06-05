module TimeToBuild
  @queue = :time2build

  def self.perform(id, time2build)
    building = Building.find(id)
    building.upgrade(0, 1000)
    puts "building upgraded"
  end
end
