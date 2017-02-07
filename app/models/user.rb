class User < ApplicationRecord
	before_save :downcase_email
	validates :name, presence: true, length: {maximum: 30}, uniqueness:true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255},
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: {case_sensitive: false}
	validates :password, presence:true, length: {minimum: 8}, allow_nil: true
	has_secure_password

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)													  
	end

	private

	def downcase_email
		email.downcase!
	end
end
