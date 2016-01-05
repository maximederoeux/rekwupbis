class Boxdetail < ActiveRecord::Base
	belongs_to :box
	has_many :articles

	accepts_nested_attributes_for :box
end
