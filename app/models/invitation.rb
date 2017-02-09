class Invitation < ApplicationRecord
	attr_accessor :invitee_email
	validates :invitee_id, presence: true
	validates :event_id, presence: true
	validates :rsvp, presence: true
	belongs_to :invitee, class_name: "User", foreign_key: :invitee_id, dependent: :destroy
	belongs_to :event
end
