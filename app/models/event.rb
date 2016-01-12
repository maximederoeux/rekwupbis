class Event < ActiveRecord::Base
	belongs_to :creator, :class_name => "User"
	belongs_to :organizer, :class_name => "User"
	has_many :offers

	validates :event_name, presence: true
	validates :event_start_date, presence: true
	validates :event_end_date, presence: true
	validates :expected_pax, presence: true

end
