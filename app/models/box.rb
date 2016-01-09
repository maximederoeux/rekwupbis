class Box < ActiveRecord::Base
	has_many :boxdetails
	has_many :offer_boxes
end
