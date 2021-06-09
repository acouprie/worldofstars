module UnitTrain
  @queue = :unitTrain

  def self.perform(id)
    unit = Unit.find(id)
    if unit.train
      puts "--- unit for id: #{id} ---"
    else
      puts "--- unit upgrade failed for id: #{id} ---"
    end
  end
end