class AddUserToPlanets < ActiveRecord::Migration[5.0]
  def change
    add_column :planets, :user_id, :integer
  end
end
