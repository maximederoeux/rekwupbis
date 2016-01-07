class NegociatedPrice < ActiveRecord::Base
	belongs_to :client, :class_name => "User"
	belongs_to :article
end
