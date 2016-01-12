class Delivery < ActiveRecord::Base
	belongs_to :offer


	scope :this_day, lambda {where(:delivery_date => Date.today)}
	scope :next_day, lambda {where(:delivery_date => Date.today + 1.day)}
	scope :three_days, lambda {where(:delivery_date => Date.today + 2.days)}
	scope :four_days, lambda {where(:delivery_date => Date.today + 3.days)}
	scope :five_days, lambda {where(:delivery_date => Date.today + 4.days)}
	scope :six_days, lambda {where(:delivery_date => Date.today + 5.days)}
	scope :not_ready, lambda {where(:is_ready => nil)}


	def offer_boxes
		self.offer.offer_boxes
	end

	def total_boxes
		offer_boxes.sum("quantity")
	end

end
