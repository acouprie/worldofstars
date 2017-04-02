class AddUserToPlanet < ActiveRecord::Migration[5.0]
  def change
    add_column :planets, :user_id, :integer
    add_index :planets, :user_id
  end
end
