class Offer < ActiveRecord::Base
	belongs_to :organizer, :class_name => "User"
	belongs_to :event

	has_many :offer_boxes
	has_many :boxes, through: :offer_boxes
	has_many :articles, through: :boxes
	has_many :sorting_details, through: :delivery
	has_many :return_boxes, through: :delivery
	has_many :washes, through: :return_boxes
	has_many :sortings, through: :delivery

	has_many :offer_articles
	has_one :delivery

	has_many :invoices

	scope :last_month, lambda {where(:updated_at => (30.days.ago.beginning_of_day..Date.today.end_of_day))}
	scope :one_day_before, lambda {where(:created_at => (Date.today.beginning_of_day - 1.day..Date.today.end_of_day - 1.day))}
	scope :this_day, lambda {where(:created_at => (Date.today.beginning_of_day..Date.today.end_of_day))}
	scope :lln_daily, lambda {where(:lln_daily => true)}

	def automatic
		if lln_invoice && lln_daily.blank?
			invoices.create(:offer_id => id, :client_id => User.is_lln.where(:lln_id => 0).first.id, :doc_invoice => true)
			@invoice = Invoice.last
			@invoice.update_attributes(:doc_number => @invoice.invoice_number)
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

end
