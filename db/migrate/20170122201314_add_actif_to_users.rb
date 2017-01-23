class AddActifToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :actif, :boolean
    add_column :users, :last_connection, :datetime
  end
end
