class Attendance < ActiveRecord::Base
	belongs_to :user

	scope :this_day, lambda {where(:start_time => (Date.current.beginning_of_day..Date.current.end_of_day))}
	scope :one_day_before, lambda {where(:start_time => (1.day.ago.beginning_of_day..1.day.ago.end_of_day))}
	scope :two_days_before, lambda {where(:start_time => (2.days.ago.beginning_of_day..2.days.ago.end_of_day))}
	scope :three_days_before, lambda {where(:start_time => (3.days.ago.beginning_of_day..3.days.ago.end_of_day))}
	scope :four_days_before, lambda {where(:start_time => (4.days.ago.beginning_of_day..4.days.ago.end_of_day))}
	scope :five_days_before, lambda {where(:start_time => (5.days.ago.beginning_of_day..5.days.ago.end_of_day))}
	scope :six_days_before, lambda {where(:start_time => (6.days.ago.beginning_of_day..6.days.ago.end_of_day))}
	scope :seven_days_before, lambda {where(:start_time => (7.days.ago.beginning_of_day..7.days.ago.end_of_day))}
	scope :eight_days_before, lambda {where(:start_time => (8.days.ago.beginning_of_day..8.days.ago.end_of_day))}
	scope :nine_days_before, lambda {where(:start_time => (9.days.ago.beginning_of_day..9.days.ago.end_of_day))}
	scope :ten_days_before, lambda {where(:start_time => (10.days.ago.beginning_of_day..10.days.ago.end_of_day))}
	scope :eleven_days_before, lambda {where(:start_time => (11.days.ago.beginning_of_day..11.days.ago.end_of_day))}
	scope :twelve_days_before, lambda {where(:start_time => (12.days.ago.beginning_of_day..12.days.ago.end_of_day))}
	scope :thirteen_days_before, lambda {where(:start_time => (13.days.ago.beginning_of_day..13.days.ago.end_of_day))}
	scope :fourteen_days_before, lambda {where(:start_time => (14.days.ago.beginning_of_day..14.days.ago.end_of_day))}
	scope :fifteen_days_before, lambda {where(:start_time => (15.days.ago.beginning_of_day..15.days.ago.end_of_day))}

	


	scope :last_week, lambda {where(:start_time => (6.days.ago.beginning_of_week.beginning_of_day..6.days.ago.end_of_week.end_of_day))}
	scope :last_monday, lambda {where(:start_time => (6.days.ago.beginning_of_week.beginning_of_day..6.days.ago.beginning_of_week.end_of_day))}
	scope :last_tuesday, lambda {where(:start_time => ((6.days.ago.beginning_of_week + 1.day).beginning_of_day..(6.days.ago.beginning_of_week + 1.day).end_of_day))}
	scope :last_wednesday, lambda {where(:start_time => ((6.days.ago.beginning_of_week + 2.days).beginning_of_day..(6.days.ago.beginning_of_week + 2.days).end_of_day))}
	scope :last_thursday, lambda {where(:start_time => ((6.days.ago.beginning_of_week + 3.days).beginning_of_day..(6.days.ago.beginning_of_week + 3.days).end_of_day))}
	scope :last_friday, lambda {where(:start_time => ((6.days.ago.beginning_of_week + 4.days).beginning_of_day..(6.days.ago.beginning_of_week + 4.days).end_of_day))}
	scope :last_saturday, lambda {where(:start_time => ((6.days.ago.beginning_of_week + 5.days).beginning_of_day..(6.days.ago.beginning_of_week + 5.days).end_of_day))}
	scope :last_sunday, lambda {where(:start_time => ((6.days.ago.beginning_of_week + 6.days).beginning_of_day..(6.days.ago.beginning_of_week + 6.days).end_of_day))}

	scope :current_month, lambda {where(:start_time => (Date.current.beginning_of_month..Date.current.end_of_month))}
	scope :last_thirty_days, lambda {where(:start_time => (30.days.ago.beginning_of_day..Date.current.end_of_day))}
	scope :last_two_months, lambda {where(:start_time => (2.months.ago.beginning_of_month..Date.current.end_of_month))}

	def duration
		if end_time.present?
			end_time - start_time
		else
			Time.now - start_time
		end
	end


	def duration_in_minutes
		(duration / 60).floor
	end

	def duration_in_hours
		(duration_in_minutes / 60).floor
	end

	def display_duration_minutes
		duration_in_minutes - (duration_in_hours * 60)
	end

	def display_duration_seconds
		duration.floor - (duration_in_minutes * 60)	
	end

	def display_duration
		"#{duration_in_hours}h#{display_duration_minutes}m"
	end

	def entire_duration(user)
		entire_duration = 0
		user.attendances.each do |attendance|
			entire_duration += attendance.duration
		end
		entire_duration		
	end

	def entire_duration_in_minutes
		(entire_duration(user) / 60).floor
	end

	def entire_duration_in_hours
		(entire_duration_in_minutes / 60).floor
	end

	def display_entire_duration_minutes
		entire_duration_in_minutes - (entire_duration_in_hours * 60)
	end

	def display_entire_duration_seconds
		entire_duration(user).floor - (entire_duration_in_minutes * 60)	
	end

	def display_entire_duration
		"#{entire_duration_in_hours}h#{display_entire_duration_minutes}m"
	end

	def this_day_duration(user)
		this_day_duration = 0
		user.attendances.this_day.each do |attendance|
			this_day_duration += attendance.duration
		end
		this_day_duration
	end

	def this_day_duration_in_minutes
		(this_day_duration(user) / 60).floor
	end

	def this_day_duration_in_hours
		(this_day_duration_in_minutes / 60).floor
	end

	def display_this_day_duration_minutes
		this_day_duration_in_minutes - (this_day_duration_in_hours * 60)
	end

	def display_this_day_duration_seconds
		this_day_duration(user).floor - (this_day_duration_in_minutes * 60)	
	end

	def display_this_day_duration
		"#{this_day_duration_in_hours}h#{display_this_day_duration_minutes}m"
	end

	def last_monday_duration(user)
		last_monday_duration = 0
		user.attendances.last_monday.each do |attendance|
			last_monday_duration += attendance.duration
		end
		last_monday_duration
	end

	def last_monday_duration_in_minutes
		(last_monday_duration(user) / 60).floor
	end

	def last_monday_duration_in_hours
		(last_monday_duration_in_minutes / 60).floor
	end

	def display_last_monday_duration_minutes
		last_monday_duration_in_minutes - (last_monday_duration_in_hours * 60)
	end

	def display_last_monday_duration_seconds
		last_monday_duration(user).floor - (last_monday_duration_in_minutes * 60)	
	end

	def display_last_monday_duration
		"#{last_monday_duration_in_hours}h#{display_last_monday_duration_minutes}m"
	end

	def last_tuesday_duration(user)
		last_tuesday_duration = 0
		user.attendances.last_tuesday.each do |attendance|
			last_tuesday_duration += attendance.duration
		end
		last_tuesday_duration
	end

	def last_tuesday_duration_in_minutes
		(last_tuesday_duration(user) / 60).floor
	end

	def last_tuesday_duration_in_hours
		(last_tuesday_duration_in_minutes / 60).floor
	end

	def display_last_tuesday_duration_minutes
		last_tuesday_duration_in_minutes - (last_tuesday_duration_in_hours * 60)
	end

	def display_last_tuesday_duration_seconds
		last_tuesday_duration(user).floor - (last_tuesday_duration_in_minutes * 60)	
	end

	def display_last_tuesday_duration
		"#{last_tuesday_duration_in_hours}h#{display_last_tuesday_duration_minutes}m"
	end

	def last_wednesday_duration(user)
		last_wednesday_duration = 0
		user.attendances.last_wednesday.each do |attendance|
			last_wednesday_duration += attendance.duration
		end
		last_wednesday_duration
	end

	def last_wednesday_duration_in_minutes
		(last_wednesday_duration(user) / 60).floor
	end

	def last_wednesday_duration_in_hours
		(last_wednesday_duration_in_minutes / 60).floor
	end

	def display_last_wednesday_duration_minutes
		last_wednesday_duration_in_minutes - (last_wednesday_duration_in_hours * 60)
	end

	def display_last_wednesday_duration_seconds
		last_wednesday_duration(user).floor - (last_wednesday_duration_in_minutes * 60)	
	end

	def display_last_wednesday_duration
		"#{last_wednesday_duration_in_hours}h#{display_last_wednesday_duration_minutes}m"
	end

	def last_thursday_duration(user)
		last_thursday_duration = 0
		user.attendances.last_thursday.each do |attendance|
			last_thursday_duration += attendance.duration
		end
		last_thursday_duration
	end

	def last_thursday_duration_in_minutes
		(last_thursday_duration(user) / 60).floor
	end

	def last_thursday_duration_in_hours
		(last_thursday_duration_in_minutes / 60).floor
	end

	def display_last_thursday_duration_minutes
		last_thursday_duration_in_minutes - (last_thursday_duration_in_hours * 60)
	end

	def display_last_thursday_duration_seconds
		last_thursday_duration(user).floor - (last_thursday_duration_in_minutes * 60)	
	end

	def display_last_thursday_duration
		"#{last_thursday_duration_in_hours}h#{display_last_thursday_duration_minutes}m"
	end

	def last_friday_duration(user)
		last_friday_duration = 0
		user.attendances.last_friday.each do |attendance|
			last_friday_duration += attendance.duration
		end
		last_friday_duration
	end

	def last_friday_duration_in_minutes
		(last_friday_duration(user) / 60).floor
	end

	def last_friday_duration_in_hours
		(last_friday_duration_in_minutes / 60).floor
	end

	def display_last_friday_duration_minutes
		last_friday_duration_in_minutes - (last_friday_duration_in_hours * 60)
	end

	def display_last_friday_duration_seconds
		last_friday_duration(user).floor - (last_friday_duration_in_minutes * 60)	
	end

	def display_last_friday_duration
		"#{last_friday_duration_in_hours}h#{display_last_friday_duration_minutes}m"
	end

	def last_saturday_duration(user)
		last_saturday_duration = 0
		user.attendances.last_saturday.each do |attendance|
			last_saturday_duration += attendance.duration
		end
		last_saturday_duration
	end

	def last_saturday_duration_in_minutes
		(last_saturday_duration(user) / 60).floor
	end

	def last_saturday_duration_in_hours
		(last_saturday_duration_in_minutes / 60).floor
	end

	def display_last_saturday_duration_minutes
		last_saturday_duration_in_minutes - (last_saturday_duration_in_hours * 60)
	end

	def display_last_saturday_duration_seconds
		last_saturday_duration(user).floor - (last_saturday_duration_in_minutes * 60)	
	end

	def display_last_saturday_duration
		"#{last_saturday_duration_in_hours}h#{display_last_saturday_duration_minutes}m"
	end

	def last_sunday_duration(user)
		last_sunday_duration = 0
		user.attendances.last_sunday.each do |attendance|
			last_sunday_duration += attendance.duration
		end
		last_sunday_duration
	end

	def last_sunday_duration_in_minutes
		(last_sunday_duration(user) / 60).floor
	end

	def last_sunday_duration_in_hours
		(last_sunday_duration_in_minutes / 60).floor
	end

	def display_last_sunday_duration_minutes
		last_sunday_duration_in_minutes - (last_sunday_duration_in_hours * 60)
	end

	def display_last_sunday_duration_seconds
		last_sunday_duration(user).floor - (last_sunday_duration_in_minutes * 60)	
	end

	def display_last_sunday_duration
		"#{last_sunday_duration_in_hours}h#{display_last_sunday_duration_minutes}m"
	end

	def last_week_duration(user)
		last_week_duration = 0
		user.attendances.last_week.each do |attendance|
			last_week_duration += attendance.duration
		end
		last_week_duration
	end

	def last_week_duration_in_minutes
		(last_week_duration(user) / 60).floor
	end

	def last_week_duration_in_hours
		(last_week_duration_in_minutes / 60).floor
	end

	def display_last_week_duration_minutes
		last_week_duration_in_minutes - (last_week_duration_in_hours * 60)
	end

	def display_last_week_duration_seconds
		last_week_duration(user).floor - (last_week_duration_in_minutes * 60)	
	end

	def display_last_week_duration
		"#{last_week_duration_in_hours}h#{display_last_week_duration_minutes}m"
	end


end
