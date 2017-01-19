class User < ApplicationRecord
	# pass the email to lowercase
	before_save { self.email = email.downcase }
	# validate presence and length of username
	validates :name, presence: true, length: { maximum: 25 }
	# add a regex to check email address
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	# validate email presence and format
	validates :email, presence: true, length: { maximum: 100 },
		format: { with: VALID_EMAIL_REGEX }, 
		uniqueness: { case_sensitive: false }
	# password contraint
	has_secure_password
	# validate password
	validates :password, presence: true, length: { minimum: 6 }
end
