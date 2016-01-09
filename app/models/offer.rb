class Offer < ActiveRecord::Base
	belongs_to :organizer, :class_name => "User"
	belongs_to :event
	has_many :offer_boxes
	has_many :offer_articles
end
