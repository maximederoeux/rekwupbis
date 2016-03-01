class Wash < ActiveRecord::Base
	belongs_to :offer

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

	def duration
		if end_time.present?
			end_time - start_time
		else
			0
		end
	end


end
