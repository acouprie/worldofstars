# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Polybius",
             email: "poly@bius.net",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             actif: true,
             last_connection: Time.zone.now)

4.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@railstutorial.org"
	password = "password"
	User.create!(name: name,
				email: email,
				password: password,
				password_confirmation: password,
				activated: true,
				activated_at: Time.zone.now,
				actif: true,
             	last_connection: Time.zone.now)
end

Planet.create!(name:  "Terre",
	user_id: 1)

Building.create!(name:  "QG")