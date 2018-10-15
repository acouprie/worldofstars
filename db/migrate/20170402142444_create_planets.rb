class CreatePlanets < ActiveRecord::Migration[5.0]
  def change
    create_table :planets do |t|
      t.belongs_to :user, index: true
      t.integer :user_id
      t.string :name, default: "Terre"
      t.integer :conso_tot, default: 0
      t.float :food_tot
      t.integer :total_food_stock, default: 1000
      t.datetime :food_time, :datetime
      t.integer :total_metal_stock, default: 1000
      t.datetime :metal_time, :datetime
      t.integer :total_thorium_stock, default: 1000
      t.datetime :thorium_time, :datetime
      t.timestamps
    end
  end
end
