class OfferBox < ActiveRecord::Base
	belongs_to :offer
	belongs_to :box

	has_many :boxdetails, through: :boxes

	def weight
		self.box.weight * quantity
	end

end
