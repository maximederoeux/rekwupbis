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

	def total_htva
		if after_event
			clean_amount + broken_amount + very_dirty_amount + handling_amount + self.offer.transport_price + article_amount
		elsif confirmation
			total_article_deposit + total_wash_deposit + self.offer.transport_price
		end
	end

	def total_tvac
		total_htva * 1.21
	end

	def total_tva
		total_tvac - total_htva
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
				Price.where(:article_id => article.id).last.washing if Price.where(:article_id => article.id).last.washing.present?
			end
		end
	end


end