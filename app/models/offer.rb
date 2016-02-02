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
	scope :this_day, lambda {where(:updated_at => Date.today.beginning_of_day..Date.today.end_of_day)}
	scope :lln_daily, lambda {where(:lln_daily => true)}

	def automatic
		if lln_daily.blank?
			offer_articles.create(:offer_id => id, :article_id => "12", :quantity => "1")
		  if event.cuptwenty
		  offer_boxes.create(:offer_id => id, :box_id => "1", :quantity => estimated_20_boxes)
		  end
		  if event.cuptwentyfive
		  offer_boxes.create(:offer_id => id, :box_id => "2", :quantity => estimated_25_boxes)
		  end
		  if event.cupforty
		  offer_boxes.create(:offer_id => id, :box_id => "3", :quantity => estimated_40_boxes)
		  end
		  if event.cupfifty
		  offer_boxes.create(:offer_id => id, :box_id => "4", :quantity => estimated_50_boxes)
		  end
		  if event.cuplitre
		  offer_boxes.create(:offer_id => id, :box_id => "5", :quantity => estimated_100_boxes)
		  end        
		  if event.cupcava
		  offer_boxes.create(:offer_id => id, :box_id => "6", :quantity => estimated_cava_boxes)
		  end
		  if event.cupwine
		  offer_boxes.create(:offer_id => id, :box_id => "7", :quantity => estimated_wine_boxes)
		  end
		  if event.cupshot
		  offer_boxes.create(:offer_id => id, :box_id => "8", :quantity => estimated_shot_boxes)
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
			(estimated_20_cups / 450).ceil
		end
	end

	def estimated_25_cups
		if event.expected_pax
		event.expected_pax * 5
		end
	end

	def estimated_25_boxes
		if event.cuptwentyfive
			(estimated_25_cups / 400).ceil
		end
	end

	def estimated_40_cups
		if event.expected_pax
		event.expected_pax * 2
		end
	end

	def estimated_40_boxes
		if event.cupforty
			(estimated_40_cups / 320).ceil
		end
	end

	def estimated_50_cups
		if event.expected_pax
		event.expected_pax * 2
		end
	end

	def estimated_50_boxes
		if event.cupfifty
			(estimated_50_cups / 280).ceil
		end
	end

	def estimated_100_cups
		if event.expected_pax
		event.expected_pax * 0.5
		end
	end

	def estimated_100_boxes
		if event.cuplitre
			(estimated_100_cups / 96).ceil
		end
	end

	def estimated_cava_cups
		if event.expected_pax
		event.expected_pax * 2
		end
	end

	def estimated_cava_boxes
		if event.cupcava
			(estimated_cava_cups / 132).ceil
		end
	end

	def estimated_wine_cups
		if event.expected_pax
		event.expected_pax * 2
		end
	end

	def estimated_wine_boxes
		if event.cupwine
			(estimated_wine_cups / 132).ceil
		end
	end

	def estimated_shot_cups
		if event.expected_pax
		event.expected_pax * 1
		end
	end

	def estimated_shot_boxes
		if event.cupshot
			(estimated_shot_cups / 500).ceil
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
