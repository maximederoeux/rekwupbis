class Article < ActiveRecord::Base
	has_many :boxdetail




	def full_name
		"#{article_name} #{article_content}"
	end


end
