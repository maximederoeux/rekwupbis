class ReturnDetail < ActiveRecord::Base
	belongs_to :return_box
	belongs_to :box

	scope :is_clean, lambda {where.not(clean: nil)}
	scope :is_dirty, lambda {where.not(dirty: nil)}
	scope :is_sealed, lambda {where.not(sealed: nil)}
	scope :is_tagged_box, lambda {where.not(tagged_box: nil)}
	scope :is_tagged_top, lambda {where.not(tagged_top: nil)}
	scope :is_missing_top, lambda {where.not(missing_top: nil)}
	scope :is_clean_ctrl, lambda {where.not(clean_ctrl: nil)}
	scope :is_dirty_ctrl, lambda {where.not(dirty_ctrl: nil)}
	scope :is_sealed_ctrl, lambda {where.not(sealed_ctrl: nil)}

	def dirty_value
		if dirty.present?
			dirty
		else
			0
		end
	end

	def sealed_value
		if sealed.present?
			sealed
		else
			0
		end
	end

	def clean_value
		if clean.present?
			clean
		else
			0
		end
	end

	def tagged_box_value
		if tagged_box.present?
			tagged_box
		else
			0
		end
	end

	def tagged_top_value
		if tagged_top.present?
			tagged_top
		else
			0
		end
	end

	def missing_top_value
		if missing_top.present?
			missing_top
		else
			0
		end
	end

	def count
		dirty_value + sealed_value + clean_value
	end

	def dirty_ctrl_value
		if dirty_ctrl.present?
			dirty_ctrl
		else
			0
		end
	end

	def sealed_ctrl_value
		if sealed_ctrl.present?
			sealed_ctrl
		else
			0
		end
	end

	def clean_ctrl_value
		if clean_ctrl.present?
			clean_ctrl
		else
			0
		end
	end

	def tagged_box_ctrl_value
		if tagged_box_ctrl.present?
			tagged_box_ctrl
		else
			0
		end
	end

	def tagged_top_ctrl_value
		if tagged_top_ctrl.present?
			tagged_top_ctrl
		else
			0
		end
	end

	def missing_top_ctrl_value
		if missing_top_ctrl.present?
			missing_top_ctrl
		else
			0
		end
	end
	def count_ctrl
		dirty_ctrl_value + sealed_ctrl_value + clean_ctrl_value
	end

end
