class Article < ActiveRecord::Base
	has_many :boxdetail




	def full_name
		if article_content.present?
		"#{article_name} #{article_content}"
		else
		"#{article_name}"
		end
	end


end
