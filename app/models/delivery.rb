class Delivery < ActiveRecord::Base
	belongs_to :offer


	def offer_boxes
		self.offer.offer_boxes
	end

	def total_boxes
		offer_boxes.sum("quantity")
	end

end
