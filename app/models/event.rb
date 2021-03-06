class Event < ActiveRecord::Base
	belongs_to :creator, :class_name => "User"
	belongs_to :organizer, :class_name => "User"
	has_many :offers

	validates :event_name, presence: true
	validates :event_start_date, presence: true
	validates :event_end_date, presence: true
	validates :expected_pax, presence: true
	validates :address, presence: true
	validates :city, presence: true
	validates :post_code, presence: true

	scope :is_lln, lambda {where(:is_lln => true)}

	def deposit_on_site_value
		if deposit_on_site.present?
			deposit_on_site
		else
			0
		end
	end
end
