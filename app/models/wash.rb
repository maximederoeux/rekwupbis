class Wash < ActiveRecord::Base
	belongs_to :return_box

	scope :this_day, lambda {where(:created_at => (Date.current.beginning_of_day..Date.current.end_of_day))}
	scope :previous_day, lambda {where(:created_at => (1.day.ago.beginning_of_day..1.day.ago.end_of_day))}
	scope :two_days_ago, lambda {where(:created_at => (2.days.ago.beginning_of_day..2.days.ago.end_of_day))}
	scope :three_days_ago, lambda {where(:created_at => (3.days.ago.beginning_of_day..3.days.ago.end_of_day))}

	
end
