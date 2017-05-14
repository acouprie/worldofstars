class CreateBuildings < ActiveRecord::Migration[5.0]
  def change
    create_table :buildings do |t|
      t.string :name
      t.integer :type
      t.integer :planet_id
      t.integer :food_price, default: 0
      t.integer :metal_price, default: 0
      t.integer :thorium_price, default: 0
      t.integer :lvl, default: 1
      t.integer :conso_power, default: 0
      t.integer :time_to_build, default: 0
      t.integer :production, default: 1

      t.timestamps
    end
  end
end
