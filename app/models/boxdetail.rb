class Boxdetail < ActiveRecord::Base
	belongs_to :box
	belongs_to :article

	accepts_nested_attributes_for :box
end
