class CreatePlanets < ActiveRecord::Migration[5.0]
  def change
    create_table :planets do |t|
    	t.belongs_to :user, index: true
      t.string :name, default: "Terre"

      t.timestamps
    end
  end
end
