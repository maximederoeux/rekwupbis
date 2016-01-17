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
	
end
