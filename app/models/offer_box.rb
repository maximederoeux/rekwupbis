class OfferBox < ActiveRecord::Base
	belongs_to :offer
	belongs_to :box
end
