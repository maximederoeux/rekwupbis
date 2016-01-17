class ReturnBox < ActiveRecord::Base
	belongs_to :delivery
	has_many :return_details

	scope :this_day, lambda {where(:return_date => Date.today)}
	scope :next_day, lambda {where(:return_date => Date.today + 1.day)}
	scope :two_days, lambda {where(:return_date => Date.today + 2.days)}
	scope :three_days, lambda {where(:return_date => Date.today + 3.days)}
	scope :next_two_weeks, lambda {where(:return_date => ((Date.today + 4.days)..(Date.today + 15.days)))}
	scope :next_year, lambda {where(:return_date => ((Date.today + 15.days)..(Date.today + 365.days)))}
	scope :previous_day, lambda {where(:return_date => Date.today - 1.day)}
	scope :two_days_ago, lambda {where(:return_date => Date.today - 2.days)}
	scope :three_days_ago, lambda {where(:return_date => Date.today - 3.days)}
	scope :received, lambda {where(:is_back => true) && where(:is_controlled => nil)}
	scope :gone, lambda {where(:is_back => true) && where(:is_controlled => true)}

def offer
	self.delivery.offer
end

def offer_boxes
	offer.offer_boxes
end

def total_boxes
	total_boxes = 0
	self.return_details.each do |box|
		total_boxes += box.count
	end
	total_boxes
	
end

end