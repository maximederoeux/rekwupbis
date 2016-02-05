class OfferBox < ActiveRecord::Base
	belongs_to :offer
	belongs_to :box

	def weight
		self.box.weight * quantity
	end

end
