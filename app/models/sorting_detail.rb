class SortingDetail < ActiveRecord::Base
	belongs_to :sorting
	belongs_to :article

	def box_value
		if box_qtty.present?
			box_qtty * self.article.quantity_bigbox
		else
			0
		end
	end

	def pile_value
		if pile_qtty.present?
			if self.article.quantity_pile.present?
				pile_qtty * self.article.quantity_pile
			else
				0
			end
		else
			0
		end
	end

	def unit_value
		if unit_qtty.present?
			unit_qtty
		else
			0
		end
	end

	def total_cups
			box_value + pile_value + unit_value
	end



end