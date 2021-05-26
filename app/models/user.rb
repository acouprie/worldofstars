class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token, :reset_token
	# pass the email to lowercase
	before_save :downcase_email
	# activation token
	before_create :create_activation_digest
	after_create :add_planet_to_user

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
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
	has_many :planets
	accepts_nested_attributes_for :planets

  def update_last_connection
    update_columns(last_connection: Time.zone.now)
    update_columns(actif: true)
  end

  def actif?
    return true unless last_connection < 2.weeks.ago
    update_columns(actif: false)
    false
  end

	# Returns the hash digest of the given string.
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
	end

  def add_planet_to_user
    Planet.create(user_id: self.id, name: 'Mars' + self.id.to_s)
  end

	# Remembers a user in the database for use in persistent sessions.
	def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest.
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	# Forgets a user.
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Activates an account.
	def activate
		update_columns(activated: true, activated_at: Time.zone.now)
	end
	# Sends activation email.
	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end
	# Sets the password reset attributes.
	def create_reset_digest
		self.reset_token = User.new_token
		self.reset_token = User.new_token
		update_columns(reset_digest: User.digest(reset_token),
					reset_sent_at: Time.zone.now)
	end
	# Sends password reset email.
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	# Returns true if a password reset has expired.
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	private

		# Converts email to all lower-case.
		def downcase_email
			self.email = email.downcase
		end

		# Creates and assigns the activation token and digest.
		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest(activation_token)
		end

end
