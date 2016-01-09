class Offer < ActiveRecord::Base
	belongs_to :organizer, :class_name => "User"
	belongs_to :event
	has_many :offer_boxes
	has_many :offer_articles


	def estimated_20_cups
		if event.expected_pax
		event.expected_pax * 8
		end
	end

	def estimated_20_boxes
		if event.cuptwenty
			(estimated_20_cups / 450).ceil
		end
	end

	def estimated_25_cups
		if event.expected_pax
		event.expected_pax * 8
		end
	end

	def estimated_25_boxes
		if event.cuptwentyfive
			(estimated_25_cups / 400).ceil
		end
	end

	def estimated_40_cups
		if event.expected_pax
		event.expected_pax * 4
		end
	end

	def estimated_40_boxes
		if event.cupforty
			(estimated_40_cups / 320).ceil
		end
	end

	def estimated_50_cups
		if event.expected_pax
		event.expected_pax * 4
		end
	end

	def estimated_50_boxes
		if event.cupfifty
			(estimated_50_cups / 280).ceil
		end
	end

	def estimated_100_cups
		if event.expected_pax
		event.expected_pax * 1
		end
	end

	def estimated_100_boxes
		if event.cuplitre
			(estimated_100_cups / 96).ceil
		end
	end

	def estimated_cava_cups
		if event.expected_pax
		event.expected_pax * 4
		end
	end

	def estimated_cava_boxes
		if event.cupcava
			(estimated_cava_cups / 132).ceil
		end
	end

	def estimated_wine_cups
		if event.expected_pax
		event.expected_pax * 4
		end
	end

	def estimated_wine_boxes
		if event.cupwine
			(estimated_wine_cups / 132).ceil
		end
	end

	def estimated_shot_cups
		if event.expected_pax
		event.expected_pax * 4
		end
	end

	def estimated_shot_boxes
		if event.cupshot
			(estimated_shot_cups / 500).ceil
		end
	end

	def automatic
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
