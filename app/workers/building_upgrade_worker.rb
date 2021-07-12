class BuildingUpgradeWorker
  include Sidekiq::Worker

  def perform(*args)
    building = Building.find(args[0])
    if building.upgrade
      puts "--- building upgraded for id: #{args[0]} ---"
    else
      puts "--- building upgrade failed for id: #{args[0]} ---"
    end
  end
end
