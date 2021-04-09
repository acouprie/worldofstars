class CreateBuildings < ActiveRecord::Migration[6.1]
  def change
    create_table :buildings do |t|
      t.string :name
      t.integer :planet_id
      t.integer :food_price, default: 0
      t.integer :metal_price, default: 0
      t.integer :thorium_price, default: 0
      t.integer :lvl, default: 0
      t.integer :conso_power, default: 0
      t.integer :time_to_build, default: 0
      t.integer :production, default: 0
      t.integer :position

      t.timestamps
    end
  end
end
