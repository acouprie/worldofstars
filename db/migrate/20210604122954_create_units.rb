class CreateUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :units do |t|
      t.string :name
      t.integer :health, default: 0
      t.integer :attack, default: 0
      t.integer :defense, default: 0
      t.integer :capacity, default: 0
      t.integer :time_to_build, default: 0
      t.integer :food_price, default: 0
      t.integer :metal_price, default: 0
      t.integer :thorium_price, default: 0
      t.integer :number, default: 0
      t.belongs_to :planet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
