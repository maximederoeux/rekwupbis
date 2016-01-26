class Article < ActiveRecord::Base
	has_many :boxdetails
	has_many :negociated_prices
	has_many :offer_articles
	has_many :sorting_details

	scope :not_washable, lambda {where.not(:is_washable => true)}


	def full_name
		if article_content.present?
		"#{article_name} #{article_content} CL"
		else
		"#{article_name}"
		end
	end


end
