class Offer < ActiveRecord::Base
	belongs_to :organizer, :class_name => "User"
	belongs_to :event

	has_many :offer_boxes
	has_many :boxes, through: :offer_boxes
	has_many :boxdetails, through: :boxes
	has_many :articles, through: :boxes
	has_many :sorting_details, through: :delivery
	has_many :return_boxes, through: :delivery
	has_many :washes, through: :return_boxes
	has_many :sortings, through: :delivery
	has_many :return_details, through: :return_boxes

	has_many :offer_articles
	has_one :delivery

	has_many :invoices

	scope :last_month, lambda {where(:updated_at => (30.days.ago.beginning_of_day..Date.today.end_of_day))}
	scope :one_day_before, lambda {where(:created_at => (Date.today.beginning_of_day - 1.day..Date.today.end_of_day - 1.day))}
	scope :this_day, lambda {where(:created_at => (Date.today.beginning_of_day..Date.today.end_of_day))}
	scope :lln_daily, lambda {where(:lln_daily => true)}

	def automatic
		if lln_invoice
			invoices.create(:offer_id => id, :client_id => User.is_lln.where(:lln_id => 0).first.id, :doc_invoice => true, :after_event => true, :lln_week_invoice => true)
			@invoice = Invoice.last
			@invoice.update_attributes(:doc_number => @invoice.invoice_number, :total_htva => @invoice.total_all_articles_htva_week, :total_tva => @invoice.total_all_articles_tva_week, :total_tvac => @invoice.total_all_articles_tvac_week)
		else
			if lln_daily.blank? && lln_invoice.blank?
				offer_articles.create(:offer_id => id, :article_id => Article.is_transport.first.id, :quantity => "1")
			  if event.cuptwenty
			  offer_boxes.create(:offer_id => id, :box_id => Box.is_rekwup.is_twenty.closed.first.id, :quantity => estimated_20_boxes)
			  end
			  if event.cuptwentyfive
			  offer_boxes.create(:offer_id => id, :box_id => Box.is_rekwup.is_twentyfive.closed.first.id, :quantity => estimated_25_boxes)
			  end
			  if event.cupforty
			  offer_boxes.create(:offer_id => id, :box_id => Box.is_rekwup.is_forty.closed.first.id, :quantity => estimated_40_boxes)
			  end
			  if event.cupfifty
			  offer_boxes.create(:offer_id => id, :box_id => Box.is_rekwup.is_fifty.closed.first.id, :quantity => estimated_50_boxes)
			  end
			  if event.cuplitre
			  offer_boxes.create(:offer_id => id, :box_id => Box.is_rekwup.is_litre.closed.first.id, :quantity => estimated_100_boxes)
			  end        
			  if event.cupcava
			  offer_boxes.create(:offer_id => id, :box_id => Box.is_rekwup.is_cava.closed.first.id, :quantity => estimated_cava_boxes)
			  end
			  if event.cupwine
			  offer_boxes.create(:offer_id => id, :box_id => Box.is_rekwup.is_wine.closed.first.id, :quantity => estimated_wine_boxes)
			  end
			  if event.cupshot
			  offer_boxes.create(:offer_id => id, :box_id => Box.is_rekwup.is_shot.closed.first.id, :quantity => "1")
			  end
			  offer_boxes.create(:offer_id => id, :box_id => Box.is_bigbox.is_empty.closed.first.id, :quantity => estimated_empty_boxes)
			end
		end
	end

	def event_name
		event.event_name	
	end

	def estimated_20_cups
		if event.expected_pax
		event.expected_pax * 2
		end
	end

	def estimated_20_boxes
		if event.cuptwenty
			(estimated_20_cups / Article.is_cc.is_twenty.first.quantity_bigbox).ceil
		end
	end

	def estimated_25_cups
		if event.expected_pax
		event.expected_pax * 5
		end
	end

	def estimated_25_boxes
		if event.cuptwentyfive
			(estimated_25_cups / Article.is_cc.is_twentyfive.first.quantity_bigbox).ceil
		end
	end

	def estimated_40_cups
		if event.expected_pax
		event.expected_pax * 2
		end
	end

	def estimated_40_boxes
		if event.cupforty
			(estimated_40_cups / Article.is_cc.is_forty.first.quantity_bigbox).ceil
		end
	end

	def estimated_50_cups
		if event.expected_pax
		event.expected_pax * 2
		end
	end

	def estimated_50_boxes
		if event.cupfifty
			(estimated_50_cups / Article.is_cc.is_fifty.first.quantity_bigbox).ceil
		end
	end

	def estimated_100_cups
		if event.expected_pax
		event.expected_pax * 0.5
		end
	end

	def estimated_100_boxes
		if event.cuplitre
			(estimated_100_cups / Article.is_cc.is_litre.first.quantity_bigbox).ceil
		end
	end

	def estimated_cava_cups
		if event.expected_pax
		event.expected_pax * 2
		end
	end

	def estimated_cava_boxes
		if event.cupcava
			(estimated_cava_cups / Article.is_cava.first.quantity_bigbox).ceil
		end
	end

	def estimated_wine_cups
		if event.expected_pax
		event.expected_pax * 2
		end
	end

	def estimated_wine_boxes
		if event.cupwine
			(estimated_wine_cups / Article.is_wine.first.quantity_bigbox).ceil
		end
	end

	def estimated_shot_cups
		if event.expected_pax
		event.expected_pax * 1
		end
	end

	def estimated_shot_boxes
		if event.cupshot
			(estimated_shot_cups / Article.is_cava.first.quantity_bigbox).ceil
		end
	end

	def estimated_empty_boxes
		if event.beertap.present?
			event.beertap
		else
			1
		end
	end

	def total_cups
		total_cups = 0
		self.offer_boxes.each do |offer_box|
			total_cups += (offer_box.box.boxdetails.last.box_article_quantity * offer_box.quantity)
		end
		total_cups
	end

	def weight
		weight = 0
		self.offer_boxes.each do |offer_box|
			weight += offer_box.weight
		end
		weight
	end

	def transport_price
		if total_cups <= 1600
			40
		elsif total_cups <= 2100 && total_cups >= 1600
			60
		elsif total_cups <= 10400 && total_cups >= 2100
			90
		elsif total_cups <= 12800 && total_cups >= 10400
			120
		elsif total_cups <= 14800 && total_cups >= 12800
			140	
		elsif total_cups <= 17200 && total_cups >= 14800
			165
		elsif total_cups <= 19200 && total_cups >= 17200
			195
		elsif total_cups <= 21200 && total_cups >= 19200
			220
		elsif total_cups <= 23600 && total_cups >= 21200
			250
		elsif total_cups <= 25600 && total_cups >= 23600
			275
		elsif total_cups <= 27600 && total_cups >= 25600
			300
		elsif total_cups <= 30000 && total_cups >= 27600
			330
		elsif total_cups <= 32000 && total_cups >= 30000
			360
		elsif total_cups <= 34400 && total_cups >= 32000
			385
		elsif total_cups <= 36400 && total_cups >= 34400
			415
		elsif total_cups <= 38400 && total_cups >= 36400
			440
		elsif total_cups <= 40800 && total_cups >= 38400
			475
		elsif total_cups >= 40800
			500
		end
	end


	def fully_confirmed
		if client_confirmation == true && admin_confirmation == true
			true
		else
			false
		end	
	end

	def has_delivery
		if self.delivery.present?
			true
		else
			false
		end
	end

	def has_return
		if has_delivery == true
			if self.delivery.return_boxes.any?
				true
			else
				false
			end
		else
			false
		end
	end

	def has_sorting
		if self.sortings.any?
			true
		else
			false
		end
	end

	def has_wash
		if self.washes.any?
			true
		else
			false
		end
	end

	def full_process
		if self.has_return && self.has_sorting && self.has_wash
			true
		else
			false
		end		
	end

	def ready_for_invoice
		if full_process == true
			if self.return_boxes.last.total_return >= 0 && self.washes.last.end_time.present? && self.sortings.last.end_time.present?
				true
			else
				false
			end
		end	
	end

	def has_invoice
		if ready_for_invoice == true
			if self.invoices.any?
				true
			else
				false
			end
		end
	end

	def has_deposit
		if has_invoice == true
			if self.invoices.is_deposit.any?
				true
			else
				false
			end
		end
	end

	def has_final
		if has_invoice == true
			if self.invoices.is_final.any?
				true
			else
				false
			end
		end
	end

	def sent_article(article)
		sent_article = 0
			self.offer_boxes.each do |offer_box|
				if Boxdetail.where(:box_id => offer_box.box_id).where(:article_id => article.id).any?
				sent_article += ((Boxdetail.where(:box_id => offer_box.box_id).where(:article_id => article.id).first.box_article_quantity) * offer_box.quantity)
				end
			end
		sent_article	
	end

	def sent_boxes(box)
		sent_boxes = 0
		self.offer_boxes.each do |offer_box|
			if offer_box.box_id == box.id
				sent_boxes += offer_box.quantity
			end
		end
		sent_boxes
	end

	def clean_boxes(box)
		clean_boxes = 0
		self.return_details.where(:box_id => box.id).each do |detail|
			if detail.clean.present?
				clean_boxes += detail.clean
			end
		end
		clean_boxes
	end

	def dirty_boxes(box)
		dirty_boxes = 0
		self.return_details.where(:box_id => box.id).each do |detail|
			if detail.dirty.present?
				dirty_boxes += detail.dirty
			end
		end
		dirty_boxes
	end

	def sealed_boxes(box)
		sealed_boxes = 0
		self.return_details.where(:box_id => box.id).each do |detail|
			if detail.sealed.present?
				sealed_boxes += detail.sealed
			end
		end
		sealed_boxes
	end

	def returned_boxes(box)
		clean_boxes(box) + dirty_boxes(box) + sealed_boxes(box)
	end

	def washed_articles(article)
		washed_articles = 0
		self.sortings.each do |sorting|
			washed_articles += sorting.global_clean_sum(article)
		end
		washed_articles
	end

	def very_dirty_articles(article)
		very_dirty_articles = 0
		self.sortings.each do |sorting|
			very_dirty_articles += sorting.global_very_dirty_sum(article)
		end
		very_dirty_articles
	end

	def handling_articles(article)
		handling_articles = 0
		self.sortings.each do |sorting|
			handling_articles += sorting.global_handling_sum(article)
		end
		handling_articles
	end

	def broken_articles(article)
		broken_articles = 0
		self.sortings.each do |sorting|
			broken_articles += sorting.global_broken_sum(article)
		end
		broken_articles
	end

	def total_articles(article)
		washed_articles(article) + very_dirty_articles(article) + handling_articles(article)
		
	end

end
