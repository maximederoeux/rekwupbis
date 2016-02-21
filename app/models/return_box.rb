class ReturnBox < ActiveRecord::Base
	belongs_to :offer
	has_many :return_details
	has_many :washes, through: :offer
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
		self.return_details.is_clean.sum('clean')
	end

	def total_dirty
		self.return_details.is_dirty.sum('dirty')
	end

	def total_sealed
		self.return_details.is_sealed.sum('sealed')
	end

	def total_tagged_box
		self.return_details.is_tagged.sum('sealed')
	end

	def total_return
		total_clean + total_dirty + total_sealed
	end

	def clean_boxes(box)
		self.return_details.is_clean.where(:box_id => box.id).sum('clean')
	end

	def dirty_boxes(box)
		self.return_details.is_dirty.where(:box_id => box.id).sum('dirty')
	end

	def sealed_boxes(box)
		self.return_details.is_sealed.where(:box_id => box.id).sum('sealed')
	end

	def tagged_boxes(box)
		self.return_details.is_tagged_box.where(:box_id => box.id).sum('tagged_box')
	end

	def tagged_tops(box)
		self.return_details.is_tagged_top.where(:box_id => box.id).sum('tagged_top')
	end

	def missing_tops(box)
		self.return_details.is_missing_top.where(:box_id => box.id).sum('missing_top')
	end

	def returned_boxes(box)
		clean_boxes(box) + dirty_boxes(box) + sealed_boxes(box)
	end

	def difference_delivery(box)
		self.offer.sent_boxes(box) - returned_boxes(box)	
	end

	def clean_ctrl_boxes(box)
		self.return_details.is_clean_ctrl.where(:box_id => box.id).sum('clean_ctrl')
	end

	def dirty_ctrl_boxes(box)
		self.return_details.is_dirty_ctrl.where(:box_id => box.id).sum('clean_ctrl')
	end

	def sealed_ctrl_boxes(box)
		self.return_details.is_sealed_ctrl.where(:box_id => box.id).sum('clean_ctrl')
	end

	def tagged_boxes_ctrl(box)
		self.return_details.is_tagged_box.where(:box_id => box.id).sum('tagged_box_ctrl')
	end

	def tagged_tops_ctrl(box)
		self.return_details.is_tagged_top.where(:box_id => box.id).sum('tagged_top_ctrl')
	end

	def missing_tops_ctrl(box)
		self.return_details.is_missing_top.where(:box_id => box.id).sum('missing_top_ctrl')
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

	def tagged_box_difference(box)
		tagged_boxes(box) - tagged_boxes_ctrl(box)
	end

	def tagged_tops_difference(box)
		tagged_tops(box) - tagged_tops_ctrl(box)
	end

	def missing_tops_difference(box)
		missing_tops(box) - missing_tops_ctrl(box)
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

	def display_tagged_box_difference(box)
		unless tagged_box_difference(box) == 0
			"Taguées"
		end	
	end

	def display_missing_tops_difference(box)
		unless missing_tops_difference(box) == 0
			"Manquants"
		end	
	end

	def display_tagged_tops_difference(box)
		unless tagged_tops_difference(box) == 0
			"Tagués"
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