class Event < ActiveRecord::Base
	belongs_to :creator, :class_name => "User"
	belongs_to :organizer, :class_name => "User"
	has_many :orders

end
