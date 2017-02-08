class Event < ApplicationRecord
	belongs_to :host, class_name: "User", foreign_key: :host_id, dependent: :destroy
	validates :name, presence: true, length: { maximum: 30 }
	validates :date, presence: true
	validates :location, presence: true, length: { maximum: 255 }
	validates :host, presence: true
	validates :description, presence: true
	has_many :invitations
end
