class Delivery < ActiveRecord::Base
	belongs_to :offer


	scope :this_day, lambda {where(:delivery_date => Date.today)}
	scope :tomorrow, lambda {where(:delivery_date => Date + 1)}

	def offer_boxes
		self.offer.offer_boxes
	end

	def total_boxes
		offer_boxes.sum("quantity")
	end


end
