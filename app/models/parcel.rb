class Parcel < ActiveRecord::Base

	belongs_to :box
	belongs_to :return_box
end
