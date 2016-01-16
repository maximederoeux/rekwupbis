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


def automatic
	if delivery_id
		offer_boxes.each do |offer_box|
			return_details.create(:return_box_id => id, :box_id => offer_box.box_id)
		end
	end
end

end