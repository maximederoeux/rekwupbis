class Invoice < ActiveRecord::Base
	belongs_to :client, :class_name => "User"
	belongs_to :offer

	has_many :sortings, through: :offer
	has_many :sorting_details, through: :offer
	has_many :offer_articles, through: :offer
	has_many :offer_boxes, through: :offer
	has_many :boxes, through: :offer_boxes
	has_many :boxdetails, through: :boxes
	has_many :articles, through: :boxdetails

	scope :debit, lambda {where(:doc_invoice => true)}
	scope :credit_note, lambda {where(:doc_credit => true)}
	scope :is_deposit, lambda {where(:confirmation => true)}
	scope :is_final, lambda {where(:after_event => true)}



	def pdf_name
		if doc_invoice
			if is_deposit
			"Facture #{created_at.strftime("%Y")} - #{doc_number} (A)"
			elsif is_final
			"Facture #{created_at.strftime("%Y")} - #{doc_number} (F)"				
			end
		elsif doc_credit
			"Note de crédit #{created_at.strftime("%Y")} - #{doc_number}"
		end
	end
	
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

	def is_deposit
		if confirmation == true
			true
		else
			false
		end
	end

	def is_final
		if after_event == true
			true
		else
			false
		end
	end


	def clean_amount
		clean_amount = 0
		self.sorting_details.clean.each do |detail|
			if detail.article.prices.last.washing.present?
				clean_amount += (detail.total_cups * detail.article.prices.last.washing)
			else
				clean_amount
			end
		end
		clean_amount
	end

	def very_dirty_amount
		very_dirty_amount = 0
		self.sorting_details.very_dirty.each do |detail|
			if detail.article.prices.last.handwash.present?
				very_dirty_amount += (detail.total_cups * detail.article.prices.last.handwash)
			else
				very_dirty_amount
			end
		end
		very_dirty_amount
	end

	def broken_amount
		broken_amount = 0
		self.sorting_details.broken.each do |detail|
			if detail.article.prices.last.deposit.present?
				broken_amount += (detail.total_cups * detail.article.prices.last.deposit)
			else
				broken_amount
			end
		end
		broken_amount
	end

	def handling_amount
		handling_amount = 0
		self.sorting_details.handling.each do |detail|
			if detail.article.prices.last.handling.present?
				handling_amount += (detail.total_cups * detail.article.prices.last.handling)
			else
				handling_amount
			end
		end
		handling_amount
	end

	def article_amount
		article_amount = 0
		self.offer.offer_articles.each do |article|
			if Price.regular.where(:article_id => article.article.id).any? && Price.regular.where(:article_id => article.article.id).last.sell.present?
				article_amount += (article.quantity * Price.regular.where(:article_id => article.article.id).last.sell) if Price.regular.where(:article_id => article.article.id).last.sell.present?
			else
				article_amount
			end
		end
		article_amount
	end

	def sent_articles(article)
		self.offer.sent_article(article)
	end

	def deposit_sent_articles(article)
		(sent_articles(article) * 0.15).floor
	end

	def deposit_wash_articles(article)
		sent_articles(article) - deposit_sent_articles(article)	
	end


	def total_article_deposit
		article_deposit = 0
		self.articles.each do |article|
    	if article.is_cup
				article_deposit += (deposit_sent_articles(article) * article.prices.last.deposit)
    	end
    end
    	article_deposit
	end

	def total_wash_deposit
		article_deposit = 0
		self.articles.each do |article|
    	if article.is_cup
				article_deposit += (deposit_wash_articles(article) * article.prices.last.washing)
    	end
    end
    	article_deposit
	end

	def total_htva_deposit
		if after_event
			clean_amount + broken_amount + very_dirty_amount + handling_amount + self.offer.transport_price + article_amount
		elsif confirmation
			total_article_deposit + total_wash_deposit + self.offer.transport_price
		end
	end

	def total_tvac_deposit
		total_htva_deposit * 1.21
	end

	def total_tva_deposit
		total_tvac_deposit - total_htva_deposit
	end

	def sent_boxes(box)
		self.offer.sent_boxes(box)
	end

	def return_clean(box)
		return_clean = 0
		self.offer.delivery.return_boxes.each do |return_box|
			return_clean += return_box.clean_boxes(box)
		end
		return_clean
	end

	def return_dirty(box)
		return_dirty = 0
		self.offer.delivery.return_boxes.each do |return_box|
			return_dirty += return_box.dirty_boxes(box)
		end
		return_dirty
	end

	def return_sealed(box)
		return_sealed = 0
		self.offer.delivery.return_boxes.each do |return_box|
			return_sealed += return_box.sealed_boxes(box)
		end
		return_sealed
	end

	def total_return(box)
		return_clean(box) + return_dirty(box) + return_sealed(box)
	end

	def difference_delivery(box)
		sent_boxes(box) - total_return(box)
	end

	def clean_return(article)
		clean_return = 0
		self.offer.sortings.each do |sorting|
		 clean_return += sorting.clean_article_return(article) if sorting.clean_article_return(article)
		end
		clean_return
	end

	def dirty_return(article)
		dirty_return = 0
		self.offer.sortings.each do |sorting|
		 dirty_return += sorting.dirty_article_return(article) if sorting.dirty_article_return(article)
		end
		dirty_return
	end

	def sealed_return(article)
		sealed_return = 0
		self.offer.sortings.each do |sorting|
		 sealed_return += sorting.sealed_article_return(article) if sorting.sealed_article_return(article)
		end
		sealed_return
	end

	def washed_total(article)
		washed_total = 0
		self.offer.sortings.each do |sorting|
			washed_total += sorting.global_clean_sum(article)
		end
		washed_total	
	end

	def very_dirty_total(article)
		very_dirty_total = 0
		self.offer.sortings.each do |sorting|
			very_dirty_total += sorting.global_very_dirty_sum(article)
		end
		very_dirty_total	
	end

	def broken_total(article)
		broken_total = 0
		self.offer.sortings.each do |sorting|
			broken_total += sorting.global_broken_sum(article)
		end
		broken_total	
	end

	def handling_total(article)
		handling_total = 0
		self.offer.sortings.each do |sorting|
			handling_total += sorting.global_handling_sum(article)
		end
		handling_total	
	end

	def total_back(article)
		clean_return(article) + washed_total(article) + very_dirty_total(article) + handling_total(article)
	end

	def right_wash_price(article)
		if Price.where(:article_id => article.id).any?
			if Price.where(:article_id => article.id).where(:user_id => self.client.id).any?
				Price.where(:article_id => article.id).where(:user_id => self.client.id).last.washing if Price.where(:article_id => article.id).where(:user_id => self.client.id).last.washing.present?
			else
				if Price.where(:article_id => article.id).last.washing.present?
					Price.where(:article_id => article.id).last.washing
				else
					0
				end
			end
		else
			0
		end
	end

	def washed_htva(article)
		right_wash_price(article) * washed_total(article)	
	end

	def washed_tvac(article)
		washed_htva(article) * 1.21
	end

	def washed_tva(article)
		washed_tvac(article) - washed_htva(article)
	end

	def right_handwash_price(article)
		if Price.where(:article_id => article.id).any?
			if Price.where(:article_id => article.id).where(:user_id => self.client.id).any?
				Price.where(:article_id => article.id).where(:user_id => self.client.id).last.handwash if Price.where(:article_id => article.id).where(:user_id => self.client.id).last.handwash.present?
			else
				if Price.where(:article_id => article.id).last.handwash.present?
					Price.where(:article_id => article.id).last.handwash
				else
					0
				end
			end
		else
			0
		end
	end

	def handwash_htva(article)
		right_wash_price(article) * very_dirty_total(article)	
	end

	def handwash_tvac(article)
		handwash_htva(article) * 1.21
	end

	def handwash_tva(article)
		handwash_tvac(article) - handwash_htva(article)
	end

	def right_handling_price(article)
		if Price.where(:article_id => article.id).any?
			if Price.where(:article_id => article.id).where(:user_id => self.client.id).any?
				Price.where(:article_id => article.id).where(:user_id => self.client.id).last.handling if Price.where(:article_id => article.id).where(:user_id => self.client.id).last.handling.present?
			else
				if Price.where(:article_id => article.id).last.handling.present?
					Price.where(:article_id => article.id).last.handling
				else
					0
				end
			end
		else
			0
		end
	end

	def handling_htva(article)
		right_handling_price(article) * handling_total(article)		
	end

	def handling_tvac(article)
		handling_htva(article) * 1.21
	end

	def handling_tva(article)
		handling_tvac(article) - handling_htva(article)
	end

	def right_deposit_price(article)
		if Price.where(:article_id => article.id).any?
			if Price.where(:article_id => article.id).where(:user_id => self.client.id).any?
				if Price.where(:article_id => article.id).where(:user_id => self.client.id).last.deposit.present?
					if self.offer.event.deposit_on_site.present?
						if self.offer.event.deposit_on_site >= Price.where(:article_id => article.id).where(:user_id => self.client.id).last.deposit
							self.offer.event.deposit_on_site / 1.21
						else
							Price.where(:article_id => article.id).where(:user_id => self.client.id).last.deposit
						end
					else
						Price.where(:article_id => article.id).where(:user_id => self.client.id).last.deposit
					end
				else
					0
				end
			else
				if Price.where(:article_id => article.id).last.deposit.present?
					if self.offer.event.deposit_on_site.present?
						if self.offer.event.deposit_on_site >= Price.where(:article_id => article.id).last.deposit
							self.offer.event.deposit_on_site / 1.21
						else
							Price.where(:article_id => article.id).last.deposit
						end
					else
						Price.where(:article_id => article.id).last.deposit
					end
				else
					0
				end
			end
		else
			0
		end
	end

	def missing_total(article)
		missing_total = 0
		self.offer.sortings.each do |sorting|
			missing_total += sorting.missing(article)
		end
		missing_total	
	end

	def missing_and_broken(article)
		broken_total(article) + missing_total(article)	
	end

	def deposit_htva(article)
		right_deposit_price(article) * missing_and_broken(article)
	end

	def deposit_tvac(article)
		deposit_htva(article) * 1.21
	end

	def deposit_tva(article)
		deposit_tvac(article) - deposit_htva(article)
	end

	def right_offer_article_price(offer_article)
		if offer_article.article.transport == true
			self.offer.transport_price
		else
			if Price.where(:article_id => offer_article.article.id).any?
				if Price.where(:article_id => offer_article.article.id).where(:user_id => self.client.id).any?
					Price.where(:article_id => offer_article.article.id).where(:user_id => self.client.id).last.sell if Price.where(:article_id => offer_article.article.id).where(:user_id => self.client.id).last.sell.present?
				else
					Price.where(:article_id => offer_article.article.id).last.sell if Price.where(:article_id => offer_article.article.id).last.sell.present?
				end
			else
				0
			end
		end
	end

	def offer_article_htva(offer_article)
		right_offer_article_price(offer_article) * offer_article.quantity		
	end

	def offer_article_tvac(offer_article)
		offer_article_htva(offer_article) * 1.21
	end

	def offer_article_tva(offer_article)
		offer_article_tvac(offer_article) - offer_article_htva(offer_article)
	end

	def total_per_article_htva(article)
		washed_htva(article) + handwash_htva(article) + handling_htva(article) + deposit_htva(article)		
	end

	def total_per_article_tva(article)
		washed_tva(article) + handwash_tva(article) + handling_tva(article) + deposit_tva(article)		
	end

	def total_per_article_tvac(article)
		washed_tvac(article) + handwash_tvac(article) + handling_tvac(article) + deposit_tvac(article)		
	end

	def total_all_articles_htva
		total_all_articles_htva = 0
		Article.all.each do |article|
			total_all_articles_htva += total_per_article_htva(article)
		end
		total_all_articles_htva
	end

	def total_all_articles_tva
		total_all_articles_tva = 0
		Article.all.each do |article|
			total_all_articles_tva += total_per_article_tva(article)
		end
		total_all_articles_tva
	end

	def total_all_articles_tvac
		total_all_articles_tvac = 0
		Article.all.each do |article|
			total_all_articles_tvac += total_per_article_tvac(article)
		end
		total_all_articles_tvac
	end

	def total_all_offer_articles_htva
		total_all_offer_articles_htva = 0
		self.offer.offer_articles.each do |offer_article|
			total_all_offer_articles_htva += offer_article_htva(offer_article)
		end
		total_all_offer_articles_htva
	end

	def total_all_offer_articles_tva
		total_all_offer_articles_tva = 0
		self.offer.offer_articles.each do |offer_article|
			total_all_offer_articles_tva += offer_article_tva(offer_article)
		end
		total_all_offer_articles_tva
	end

	def total_all_offer_articles_tvac
		total_all_offer_articles_tvac = 0
		self.offer.offer_articles.each do |offer_article|
			total_all_offer_articles_tvac += offer_article_tvac(offer_article)
		end
		total_all_offer_articles_tvac
	end

	def total_htva_final
		total_all_articles_htva + total_all_offer_articles_htva
	end

	def total_tva_final
		total_all_articles_tva + total_all_offer_articles_tva
	end

	def total_tvac_final
		total_all_articles_tvac + total_all_offer_articles_tvac
	end

# LLN INVOICES

	def week_begin
		(created_at - 7.days).beginning_of_week
	end

	def week_finish
		(created_at - 7.days).end_of_week
	end

	def sent_boxes_week(box)
		sent_boxes_week = 0
		Offer.where(:event_id => Event.where(:is_lln => true).last.id).where(created_at: week_begin..week_finish).each do |offer|
			sent_boxes_week += offer.sent_boxes(box)
		end
		sent_boxes_week
	end

	def clean_boxes_week(box)
		clean_boxes_week = 0
		Offer.where(:event_id => Event.where(:is_lln => true).last.id).where(created_at: week_begin..week_finish).each do |offer|
			clean_boxes_week += offer.clean_boxes(box)
		end
		clean_boxes_week
	end

	def dirty_boxes_week(box)
		dirty_boxes_week = 0
		Offer.where(:event_id => Event.where(:is_lln => true).last.id).where(created_at: week_begin..week_finish).each do |offer|
			dirty_boxes_week += offer.dirty_boxes(box)
		end
		dirty_boxes_week
	end

	def sealed_boxes_week(box)
		sealed_boxes_week = 0
		Offer.where(:event_id => Event.where(:is_lln => true).last.id).where(created_at: week_begin..week_finish).each do |offer|
			sealed_boxes_week += offer.sealed_boxes(box)
		end
		sealed_boxes_week
	end

	def returned_boxes_week(box)
		clean_boxes_week(box) + dirty_boxes_week(box) + sealed_boxes_week(box)
	end

	def sent_articles_week(article)
		sent_articles_week = 0
		Offer.where(:event_id => Event.where(:is_lln => true).last.id).where(created_at: week_begin..week_finish).each do |offer|
			sent_articles_week += offer.sent_article(article)
		end
		sent_articles_week
	end

	def washed_articles_week(article)
		washed_articles_week = 0
		Offer.where(:event_id => Event.where(:is_lln => true).last.id).where(created_at: week_begin..week_finish).each do |offer|
			washed_articles_week += offer.washed_articles(article)
		end
		washed_articles_week
	end

	def very_dirty_articles_week(article)
		very_dirty_articles_week = 0
		Offer.where(:event_id => Event.where(:is_lln => true).last.id).where(created_at: week_begin..week_finish).each do |offer|
			very_dirty_articles_week += offer.very_dirty_articles(article)
		end
		very_dirty_articles_week
	end

	def handling_articles_week(article)
		handling_articles_week = 0
		Offer.where(:event_id => Event.where(:is_lln => true).last.id).where(created_at: week_begin..week_finish).each do |offer|
			handling_articles_week += offer.handling_articles(article)
		end
		handling_articles_week
	end

	def broken_articles_week(article)
		broken_articles_week = 0
		Offer.where(:event_id => Event.where(:is_lln => true).last.id).where(created_at: week_begin..week_finish).each do |offer|
			broken_articles_week += offer.broken_articles(article)
		end
		broken_articles_week
	end

	def total_articles_week(article)
		washed_articles_week(article) + very_dirty_articles_week(article) + handling_articles_week(article)
		
	end

	def washed_htva_week(article)
		right_wash_price(article) * washed_articles_week(article)	
	end

	def washed_tvac_week(article)
		washed_htva_week(article) * 1.21
	end

	def washed_tva_week(article)
		washed_tvac_week(article) - washed_htva_week(article)
	end

	def handwash_htva_week(article)
		right_handwash_price(article) * very_dirty_articles_week(article)	
	end

	def handwash_tvac_week(article)
		handwash_htva_week(article) * 1.21
	end

	def handwash_tva_week(article)
		handwash_tvac_week(article) - handwash_htva_week(article)
	end

	def handling_htva_week(article)
		right_handling_price(article) * handling_articles_week(article)	
	end

	def handling_tvac_week(article)
		handling_htva_week(article) * 1.21
	end

	def handling_tva_week(article)
		handling_tvac_week(article) - handling_htva_week(article)
	end

	def deposit_htva_week(article)
		right_deposit_price(article) * broken_articles_week(article)
	end

	def deposit_tvac_week(article)
		deposit_htva_week(article) * 1.21
	end

	def deposit_tva_week(article)
		deposit_tvac_week(article) - deposit_htva_week(article)
	end

	def total_per_article_htva_week(article)
		washed_htva_week(article) + handwash_htva_week(article) + handling_htva_week(article) + deposit_htva_week(article)		
	end

	def total_per_article_tva_week(article)
		washed_tva_week(article) + handwash_tva_week(article) + handling_tva_week(article) + deposit_tva_week(article)		
	end

	def total_per_article_tvac_week(article)
		washed_tvac_week(article) + handwash_tvac_week(article) + handling_tvac_week(article) + deposit_tvac_week(article)		
	end

	def total_all_articles_htva_week
		total_all_articles_htva_week = 0
		Article.all.each do |article|
			total_all_articles_htva_week += total_per_article_htva_week(article)
		end
		total_all_articles_htva_week
	end

	def total_all_articles_tva_week
		total_all_articles_tva_week = 0
		Article.all.each do |article|
			total_all_articles_tva_week += total_per_article_tva_week(article)
		end
		total_all_articles_tva_week
	end

	def total_all_articles_tvac_week
		total_all_articles_tvac_week = 0
		Article.all.each do |article|
			total_all_articles_tvac_week += total_per_article_tvac_week(article)
		end
		total_all_articles_tvac_week
	end
		
end