module CancelAbandonedOrders
  @queue = :cancelAbandonedOrders

  def self.perform()
    puts("Cancelled order.")
  end
end
