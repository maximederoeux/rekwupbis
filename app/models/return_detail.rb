class ReturnDetail < ActiveRecord::Base
	belongs_to :return_box
	belongs_to :box
end
