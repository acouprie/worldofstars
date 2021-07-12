class UnitTrainWorker
  include Sidekiq::Worker

  def perform(*args)
    unit = Unit.find(args[0])
    if unit.train
      puts "--- unit for id: #{args[0]} ---"
    else
      puts "--- unit upgrade failed for id: #{args[0]} ---"
    end
  end
end
