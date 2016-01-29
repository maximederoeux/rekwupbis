class ReturnDetail < ActiveRecord::Base
	belongs_to :return_box
	belongs_to :box


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

	def count_ctrl
		dirty_ctrl_value + sealed_ctrl_value + clean_ctrl_value
	end

end
