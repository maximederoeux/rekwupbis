class Delivery < ActiveRecord::Base
	belongs_to :offer
	has_many :return_boxes

	has_many :washes, through: :return_boxes
	has_many :sortings, through: :return_boxes
	has_many :sorting_details, through: :sortings


	scope :this_day, lambda {where(:delivery_date => Date.today)}
	scope :sent_this_day, lambda {where(:gone_time => (Date.current.beginning_of_day..Date.current.end_of_day))}
	scope :next_day, lambda {where(:delivery_date => Date.today + 1.day)}
	scope :two_days, lambda {where(:delivery_date => Date.today + 2.days)}
	scope :three_days, lambda {where(:delivery_date => Date.today + 3.days)}
	scope :next_two_weeks, lambda {where(:delivery_date => ((Date.today + 4.days)..(Date.today + 15.days)))}
	scope :next_year, lambda {where(:delivery_date => ((Date.today + 15.days)..(Date.today + 365.days)))}
	scope :previous_day, lambda {where(:delivery_date => Date.today - 1.day)}
	scope :sent_previous_day, lambda {where(:gone_time => (1.day.ago.beginning_of_day..1.day.ago.end_of_day))}
	scope :two_days_ago, lambda {where(:delivery_date => Date.today - 2.days)}
	scope :sent_two_days_ago, lambda {where(:gone_time => (2.days.ago.beginning_of_day..2.days.ago.end_of_day))}
	scope :three_days_ago, lambda {where(:delivery_date => (3.days.ago.beginning_of_day..3.days.ago.end_of_day))}
	scope :sent_three_days_ago, lambda {where(:gone_time => Date.today - 3.days)}
	scope :ready, lambda {where(:is_ready => true) && where(:is_gone => nil)}
	scope :gone, lambda {where(:is_ready => true) && where(:is_gone => true)}


	def offer_boxes
		self.offer.offer_boxes
	end

	def total_boxes
		offer_boxes.sum("quantity")
	end

	def not_ready
		self.where(:is_ready => nil)
	end

	def create_return
	  if is_gone
	  return_boxes.create(:delivery_id => id, :return_date => return_date)
	  end
	end

end
