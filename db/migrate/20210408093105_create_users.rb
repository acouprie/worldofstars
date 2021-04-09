class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin, default: false
      t.string :activation_digest
      t.boolean :activated
      t.datetime :activated_at
      t.datetime :reset_sent_at
      t.string :reset_digest
      t.boolean :actif
      t.datetime :last_connection

      t.timestamps
    end
  end
end
