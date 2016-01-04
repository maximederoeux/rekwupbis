class Article < ActiveRecord::Base




	def full_name
		"#{article_name} #{article_content}"
	end


end
