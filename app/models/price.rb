class Price < ActiveRecord::Base
	belongs_to :user
	belongs_to :article

	scope :regular, lambda {where(:regular => true)}
	scope :negociated, lambda {where(:negociated => true)}

end
