class CreatePlanets < ActiveRecord::Migration[6.1]
  def change
    create_table :planets do |t|
      t.belongs_to :user, index: true
      t.string :name, default: "Terre"
      t.float :food_tot
      t.integer :total_food_stock, default: 1000
      t.datetime :food_time, default: Time.now
      t.integer :total_metal_stock, default: 1000
      t.datetime :metal_time, default: Time.now
      t.integer :total_thorium_stock, default: 1000
      t.datetime :thorium_time, default: Time.now

      t.timestamps
    end
  end
end
