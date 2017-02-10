class User < ApplicationRecord
	attr_accessor :remember_token
	before_save :downcase_email
	validates :name, presence: true, length: {maximum: 30}, uniqueness:true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255},
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: {case_sensitive: false}
	validates :password, presence:true, length: {minimum: 8}, allow_nil: true
	has_secure_password
	has_many :events, foreign_key: :host_id
	has_many :invitations, foreign_key: :invitee_id

	def User.new_token
		SecureRandom.base64
	end

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)													  
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def coming_up_events
		going_invitations = self.invitations.where('rsvp == "going"')
		events = []
		going_invitations.each do |invitation|
			events << invitation.event if invitation.event.date > Time.zone.now
		end
		events
	end

	def need_rsvp
		invitations = self.invitations.find_by(rsvp: "no response")
		invites = []
		return invites if invitations.nil?
		invitations.is_a?(Invitation) ? invites << invitations : invitations.each {|i| invites << i}
		invites
	end

	private

	def downcase_email
		email.downcase!
	end
end
