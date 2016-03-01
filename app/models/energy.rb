class Energy < ActiveRecord::Base


	def daily_electricity
		if Energy.where('created_at < ?', created_at).last.present?
			if electricity.present? && two_electricity.present? && Energy.where('created_at < ?', created_at).last.electricity.present? && Energy.where('created_at < ?', created_at).last.two_electricity.present?
			(electricity + two_electricity) - (Energy.where('created_at < ?', created_at).last.electricity + Energy.where('created_at < ?', created_at).last.two_electricity)
			end
		else
			0
		end
	end

	def daily_photo
		if Energy.where('created_at < ?', created_at).last.present?
			if photo.present? && two_photo.present? && Energy.where('created_at < ?', created_at).last.photo.present? && Energy.where('created_at < ?', created_at).last.two_photo.present?
			(photo + two_photo) - (Energy.where('created_at < ?', created_at).last.photo + Energy.where('created_at < ?', created_at).last.two_photo)
			end
		else
			0
		end
	end

	def daily_gaz
		if Energy.where('created_at < ?', created_at).last.present?
			if gaz.present? && two_gaz.present? && Energy.where('created_at < ?', created_at).last.gaz.present? && Energy.where('created_at < ?', created_at).last.two_gaz.present?
			(gaz + two_gaz) - (Energy.where('created_at < ?', created_at).last.gaz + Energy.where('created_at < ?', created_at).last.two_gaz)
			end
		else
			0
		end
	end

	def daily_water
		if Energy.where('created_at < ?', created_at).last.present?
			if water.present? && two_water.present? && three_water.present? && four_water.present? && Energy.where('created_at < ?', created_at).last.water.present? && Energy.where('created_at < ?', created_at).last.two_water.present? && Energy.where('created_at < ?', created_at).last.three_water.present? && Energy.where('created_at < ?', created_at).last.four_water.present?
			(water + two_water + three_water + four_water) - (Energy.where('created_at < ?', created_at).last.water + Energy.where('created_at < ?', created_at).last.two_water + Energy.where('created_at < ?', created_at).last.three_water + Energy.where('created_at < ?', created_at).last.four_water)
			end
		else
			0
		end
	end

	def total_cups
		total_cups = 0
		SortingDetail.clean.where(:updated_at => (self.created_at.beginning_of_day..self.created_at.end_of_day)).each do |detail|
			if detail.article.is_cup
			total_cups += detail.total_cups
			end
		end
		total_cups	
	end

	def total_boxes
		total_boxes = 0
		ReturnBox.gone.where(:return_time => (self.created_at.beginning_of_day..self.created_at.end_of_day)).each do |return_box|
			total_boxes += return_box.total_return
		end
		total_boxes
	end

	def duration
		duration = 0
		Attendance.where(:created_at => (self.created_at.beginning_of_day..self.created_at.end_of_day)).each do |attendance|
			duration += attendance.duration
		end
		duration
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

	def cups_per_hour
		if duration_in_minutes >= 0.1
			total_cups / duration_in_minutes * 60
		else
			total_cups
		end	
	end

end
