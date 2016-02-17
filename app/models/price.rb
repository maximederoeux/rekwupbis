class Price < ActiveRecord::Base
	belongs_to :user
	belongs_to :article

	scope :regular, lambda {where(:regular => true)}
	scope :negociated, lambda {where(:negociated => true)}


	def washing_value
		if washing.present?
			washing
		else
			0
		end
	end

	def deposit_value
		if deposit.present?
			deposit
		else
			0
		end
	end

	def handwash_value
		if handwash.present?
			handwash
		else
			0
		end
	end

	def handling_value
		if handling.present?
			handling
		else
			0
		end
	end

	def sell_value
		if sell.present?
			sell
		else
			0
		end
	end

end
