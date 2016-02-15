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

end
