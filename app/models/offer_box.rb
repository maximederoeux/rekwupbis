class OfferBox < ActiveRecord::Base
	belongs_to :offer
	belongs_to :box

	has_many :boxdetails, through: :box
	has_many :articles, through: :boxdetails


	def weight
		self.box.weight * quantity
	end

end
