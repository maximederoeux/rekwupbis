class SortingDetail < ActiveRecord::Base
	belongs_to :sorting
	belongs_to :article


	scope :clean, lambda {where(:clean => true)}
	scope :very_dirty, lambda {where(:very_dirty => true)}
	scope :broken, lambda {where(:broken => true)}
	scope :handling, lambda {where(:handling => true)}
	scope :has_box, lambda {where.not(box_qtty: nil)}
	scope :has_pile, lambda {where.not(pile_qtty: nil)}
	scope :has_unit, lambda {where.not(unit_qtty: nil)}

	def box_value
		if box_qtty.present? 
			if self.quantity_bigbox.present?
				box_qtty * self.article.quantity_bigbox
			else
				0
			end
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