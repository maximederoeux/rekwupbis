class Sorting < ActiveRecord::Base
	belongs_to :offer
	has_many :sorting_details

	has_many :return_boxes, through: :offer

	has_many :articles, through: :sorting_details
	has_many :return_details, through: :return_boxes

	scope :this_day, lambda {where(:created_at => (Date.current.beginning_of_day..Date.current.end_of_day))}
	scope :previous_day, lambda {where(:created_at => (1.day.ago.beginning_of_day..1.day.ago.end_of_day))}
	scope :two_days_ago, lambda {where(:created_at => (2.days.ago.beginning_of_day..2.days.ago.end_of_day))}
	scope :fifteen_days_ago, lambda {where(:created_at => (15.days.ago.beginning_of_day..3.days.ago.end_of_day))}
	scope :started_this_day, lambda {where(:start_time => (Date.current.beginning_of_day..Date.current.end_of_day))}
	scope :started_previous_day, lambda {where(:start_time => (1.day.ago.beginning_of_day..1.day.ago.end_of_day))}
	scope :started_two_days_ago, lambda {where(:start_time => (2.days.ago.beginning_of_day..2.days.ago.end_of_day))}
	scope :started_fifteen_days_ago, lambda {where(:start_time => (15.days.ago.beginning_of_day..3.days.ago.end_of_day))}
	scope :ended_this_day, lambda {where(:end_time => (Date.current.beginning_of_day..Date.current.end_of_day))}
	scope :ended_previous_day, lambda {where(:end_time => (1.day.ago.beginning_of_day..1.day.ago.end_of_day))}
	scope :ended_two_days_ago, lambda {where(:end_time => (2.days.ago.beginning_of_day..2.days.ago.end_of_day))}
	scope :ended_fifteen_days_ago, lambda {where(:end_time => (15.days.ago.beginning_of_day..3.days.ago.end_of_day))}
	

	def global_clean_sum(article)
		if article.is_cup
		(self.sorting_details.clean.has_box.where(:article_id => article.id).sum('box_qtty') * article.box_value) + (self.sorting_details.clean.has_pile.where(:article_id => article.id).sum('pile_qtty') * article.pile_value) + self.sorting_details.clean.has_unit.where(:article_id => article.id).sum('unit_qtty')
		else
			0
		end
	end

	def global_very_dirty_sum(article)
		(self.sorting_details.very_dirty.has_box.where(:article_id => article.id).sum('box_qtty') * article.box_value) + (self.sorting_details.very_dirty.has_pile.where(:article_id => article.id).sum('pile_qtty') * article.pile_value) + self.sorting_details.very_dirty.has_unit.where(:article_id => article.id).sum('unit_qtty')
	end

	def global_broken_sum(article)
		(self.sorting_details.broken.has_box.where(:article_id => article.id).sum('box_qtty') * article.box_value) + (self.sorting_details.broken.has_pile.where(:article_id => article.id).sum('pile_qtty') * article.pile_value) + self.sorting_details.broken.has_unit.where(:article_id => article.id).sum('unit_qtty')
	end

	def global_handling_sum(article)
		if article.is_cup
		(self.sorting_details.handling.has_box.where(:article_id => article.id).sum('box_qtty') * article.box_value) + (self.sorting_details.handling.has_pile.where(:article_id => article.id).sum('pile_qtty') * article.pile_value) + self.sorting_details.handling.has_unit.where(:article_id => article.id).sum('unit_qtty')
		else
			sealed_box_return(article)
		end
	end

	def total_sorting(article)
		global_clean_sum(article) + global_very_dirty_sum(article) + global_broken_sum(article) + global_handling_sum(article)
	end

	def sent_article(article)
		self.offer.sent_article(article)
		
	end


	def missing(article)
		if sent_article(article).present? && total_sorting(article).present? && clean_article_return(article).present?
			sent_article(article) - total_sorting(article) - clean_article_return(article)
		else
			0
		end
	end

	def clean_box_return(article)
		clean_box_return = 0
		self.return_details.where('clean > ?', 0).find_each do |return_detail|
				if return_detail.box.articles.where(:id => article.id).any?
				clean_box_return += return_detail.clean
				end
		end
		clean_box_return
	end

	def clean_article_return(article)
		if article.is_cup
			(clean_box_return(article) * article.quantity_bigbox) if article.quantity_bigbox.present?
		else
			clean_box_return(article)
		end
	end

	def dirty_box_return(article)
		dirty_box_return = 0
		self.return_details.where('dirty > ?', 0).find_each do |return_detail|
				if return_detail.box.articles.where(:id => article.id).any?
				dirty_box_return += return_detail.dirty
				end
		end
		dirty_box_return
	end

	def sealed_box_return(article)
		sealed_box_return = 0
		self.return_details.where('sealed > ?', 0).find_each do |return_detail|
				if return_detail.box.articles.where(:id => article.id).any?
				sealed_box_return += return_detail.sealed
				end
		end
		sealed_box_return
	end

end
