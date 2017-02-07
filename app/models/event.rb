class Event < ApplicationRecord
	belongs_to :user, :foreign_key => 'host', dependent: :destroy
	validates :name, presence: true, length: { maximum: 30 }
	validates :date, presence: true
	validates :location, presence: true, length: { maximum: 255 }
	validates :host, presence: true
end
