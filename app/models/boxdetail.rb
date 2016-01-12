class Boxdetail < ActiveRecord::Base
	belongs_to :box
	belongs_to :article

	accepts_nested_attributes_for :box


	def weight
		if self.article.weight.present?
		self.box_article_quantity * self.article.weight
		else
		0
		end
	end
end
