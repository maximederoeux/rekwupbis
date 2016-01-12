class Boxdetail < ActiveRecord::Base
	belongs_to :box
	belongs_to :article

	accepts_nested_attributes_for :box


	def weight
		self.box_article_quantity * self.article.weight
	end
end
