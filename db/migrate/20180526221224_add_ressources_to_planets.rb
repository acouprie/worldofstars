class AddRessourcesToPlanets < ActiveRecord::Migration[5.0]
  def change
    add_column :planets, :total_food_stock, :float
    add_column :planets, :food_time, :datetime
    add_column :planets, :total_metal_stock, :float
    add_column :planets, :metal_time, :datetime
    add_column :planets, :total_thorium_stock, :float
    add_column :planets, :thorium_time, :datetime
  end
end
