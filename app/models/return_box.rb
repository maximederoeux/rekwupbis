class ReturnBox < ActiveRecord::Base
	belongs_to :offer
	has_many :return_details
	has_many :washes
	has_many :sortings, through: :offer
	has_many :parcels

	

	accepts_nested_attributes_for :return_details, :allow_destroy => true

	scope :this_day, lambda {where(:return_date => Date.today)}
	scope :back_this_day, lambda {where(:return_time => (Date.current.beginning_of_day..Date.current.end_of_day))}
	scope :next_day, lambda {where(:return_date => Date.today + 1.day)}
	scope :two_days, lambda {where(:return_date => Date.today + 2.days)}
	scope :three_days, lambda {where(:return_date => Date.today + 3.days)}
	scope :next_two_weeks, lambda {where(:return_date => ((Date.today + 4.days)..(Date.today + 15.days)))}
	scope :next_year, lambda {where(:return_date => ((Date.today + 15.days)..(Date.today + 365.days)))}
	scope :back_previous_day, lambda {where(:return_time => (1.day.ago.beginning_of_day..1.day.ago.end_of_day))}
	scope :back_two_days_ago, lambda {where(:return_time => (2.days.ago.beginning_of_day..2.days.ago.end_of_day))}
	scope :back_fifteen_days_ago, lambda {where(:return_time => (15.days.ago.beginning_of_day..3.days.ago.end_of_day))}
	scope :received, lambda {where(:is_back => true) && where(:is_controlled => nil)}
	scope :gone, lambda {where(:is_back => true) && where(:is_controlled => true)}
	scope :before_today, lambda {where('return_date < ?', Date.today)}


	def delivery
		self.offer.delivery	
	end

	def total_clean
		total_clean = 0
		self.return_details.each do |detail|
			if detail.clean.present?
				total_clean += detail.clean
			end
		end
		total_clean
	end

	def total_dirty
		total_dirty = 0
		self.return_details.each do |detail|
			if detail.dirty.present?
				total_dirty += detail.dirty
			end
		end
		total_dirty
	end

	def total_sealed
		total_sealed = 0
		self.return_details.each do |detail|
			if detail.sealed.present?
				total_sealed += detail.sealed
			end
		end
		total_sealed
	end

	def total_return
		total_clean + total_dirty + total_sealed
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

	def difference_delivery(box)
		self.offer.sent_boxes(box) - returned_boxes(box)	
	end

	def clean_ctrl_boxes(box)
		clean_ctrl_boxes = 0
		self.return_details.where(:box_id => box.id).each do |detail|
			if detail.clean_ctrl.present?
				clean_ctrl_boxes += detail.clean_ctrl
			end
		end
		clean_ctrl_boxes
	end

	def dirty_ctrl_boxes(box)
		dirty_ctrl_boxes = 0
		self.return_details.where(:box_id => box.id).each do |detail|
			if detail.dirty_ctrl.present?
				dirty_ctrl_boxes += detail.dirty_ctrl
			end
		end
		dirty_ctrl_boxes
	end

	def sealed_ctrl_boxes(box)
		sealed_ctrl_boxes = 0
		self.return_details.where(:box_id => box.id).each do |detail|
			if detail.sealed_ctrl.present?
				sealed_ctrl_boxes += detail.sealed_ctrl
			end
		end
		sealed_ctrl_boxes
	end

	def clean_difference(box)
		clean_boxes(box) - clean_ctrl_boxes(box)
	end

	def dirty_difference(box)
		dirty_boxes(box) - dirty_ctrl_boxes(box)
	end	

	def sealed_difference(box)
		sealed_boxes(box) - sealed_ctrl_boxes(box)
	end

	def display_clean_difference(box)
		unless clean_difference(box) == 0
			"Propres"
		end
	end

	def display_dirty_difference(box)
		unless dirty_difference(box) == 0
			"Sales"
		end
	end

	def display_sealed_difference(box)
		unless sealed_difference(box) == 0
			"Scellées"
		end	
	end

	def status
		if is_back == nil && is_controlled == nil && send_wash == nil
			"Ce retour est à recevoir"
		elsif is_back == true && is_controlled == nil && send_wash == nil
			"Ce retour est à contrôler"
		elsif is_back == true && is_controlled == true && send_wash == nil
			"Ce retour est contrôlé"
		elsif is_back == true && is_controlled == true && send_wash == true
		"Ce retour est envoyé au lavage"
		end
	end


end