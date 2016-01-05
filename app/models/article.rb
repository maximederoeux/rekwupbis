class Article < ActiveRecord::Base
	belongs_to :boxdetail




	def full_name
		"#{article_name} #{article_content}"
	end


end
