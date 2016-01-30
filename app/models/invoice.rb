class Invoice < ActiveRecord::Base
		belongs_to :client, :class_name => "User"
		belongs_to :offer

	scope :debit, lambda {where(:doc_invoice => true)}
	scope :credit_note, lambda {where(:doc_credit => true)}


	def previous_invoice
		Invoice.where("created_at < ?", created_at).last
		
	end

	def previous_debit
		Invoice.debit.where("created_at < ?", created_at).last
	end

	def previous_credit
		Invoice.credit_note.where("created_at < ?", created_at).last
	end


	def invoice_number
		if doc_invoice && previous_debit && previous_debit.doc_number
			previous_debit.doc_number + 1
		else
			1
		end
	end

	def credit_number	
		if doc_credit && previous_credit && previous_credit.doc_number
			previous_credit.doc_number + 1
		else
			1
		end
	end

end