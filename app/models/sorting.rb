class Sorting < ActiveRecord::Base
	belongs_to :return_box
	has_many :sorting_details

	has_many :articles, through: :sorting_details
	has_many :return_details, through: :return_box

	scope :this_day, lambda {where(:created_at => (Date.current.beginning_of_day..Date.current.end_of_day))}
	scope :previous_day, lambda {where(:created_at => (1.day.ago.beginning_of_day..1.day.ago.end_of_day))}
	scope :two_days_ago, lambda {where(:created_at => (2.days.ago.beginning_of_day..2.days.ago.end_of_day))}
	scope :three_days_ago, lambda {where(:created_at => (3.days.ago.beginning_of_day..3.days.ago.end_of_day))}
	scope :started_this_day, lambda {where(:start_time => (Date.current.beginning_of_day..Date.current.end_of_day))}
	scope :started_previous_day, lambda {where(:start_time => (1.day.ago.beginning_of_day..1.day.ago.end_of_day))}
	scope :started_two_days_ago, lambda {where(:start_time => (2.days.ago.beginning_of_day..2.days.ago.end_of_day))}
	scope :started_three_days_ago, lambda {where(:start_time => (3.days.ago.beginning_of_day..3.days.ago.end_of_day))}
	scope :ended_this_day, lambda {where(:end_time => (Date.current.beginning_of_day..Date.current.end_of_day))}
	scope :ended_previous_day, lambda {where(:end_time => (1.day.ago.beginning_of_day..1.day.ago.end_of_day))}
	scope :ended_two_days_ago, lambda {where(:end_time => (2.days.ago.beginning_of_day..2.days.ago.end_of_day))}
	scope :ended_three_days_ago, lambda {where(:end_time => (3.days.ago.beginning_of_day..3.days.ago.end_of_day))}
	

	def global_clean_sum(article)
		global_clean_sum = 0
		self.sorting_details.where(:article_id => article, :clean => true).each do |sorting_detail|
			global_clean_sum += sorting_detail.total_cups
		end
		global_clean_sum
	end

	def global_very_dirty_sum(article)
		global_very_dirty_sum = 0
		self.sorting_details.where(:article_id => article, :very_dirty => true).each do |sorting_detail|
			global_very_dirty_sum += sorting_detail.total_cups
		end
		global_very_dirty_sum
	end

	def global_broken_sum(article)
		global_broken_sum = 0
		self.sorting_details.where(:article_id => article, :broken => true).each do |sorting_detail|
			global_broken_sum += sorting_detail.total_cups
		end
		global_broken_sum
	end

	def global_handling_sum(article)
		global_handling_sum = 0
		self.sorting_details.where(:article_id => article, :handling => true).each do |sorting_detail|
			global_handling_sum += sorting_detail.total_cups
		end
		global_handling_sum
	end

	def total_sorting(article)
		global_clean_sum(article) + global_very_dirty_sum(article) + global_broken_sum(article) + global_handling_sum(article)
	end



	def missing(article)
		self.return_box.delivery.offer.sent_article(article) - total_sorting	
	end

	def clean_box_return(article)
		clean_box_return = 0
		self.return_box.return_details.where('clean > ?', 0).each do |return_detail|
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

end
