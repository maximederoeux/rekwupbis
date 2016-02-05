class OfferBox < ActiveRecord::Base
	belongs_to :offer, counter_cache: true
	belongs_to :box

	def weight
		self.box.weight * quantity
	end

end
