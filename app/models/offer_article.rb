class OfferArticle < ActiveRecord::Base
	belongs_to :offer
	belongs_to :article
end
