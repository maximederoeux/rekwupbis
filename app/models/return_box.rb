class ReturnBox < ActiveRecord::Base
	belongs_to :delivery
	has_many :return_details
	has_many :washes
	has_many :sortings
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

	def offer
		self.delivery.offer
	end

	def offer_boxes
		offer.offer_boxes
	end

	def total_boxes
		total_boxes = 0
		self.return_details.each do |box|
			total_boxes += box.count
		end
		total_boxes
	end

	def difference
		if self.delivery.total_boxes == 0
			0
		else
		total_boxes - self.delivery.total_boxes
		end
	end

	def display_difference
		if total_boxes == 0
			I18n.t('return.not_received_yet')
		else
			if difference == 0
				I18n.t('return.no_difference')
			elsif difference >= 0
				I18n.t('return.positive_difference', :difference => difference)
			elsif difference <= 0
				I18n.t('return.negative_difference', :difference => (0 - difference))
			end
		end
	end

		def total_ctrl_boxes
		total_ctrl_boxes = 0
		self.return_details.each do |box|
			total_ctrl_boxes += box.count_ctrl
		end
		total_ctrl_boxes
	end

	def difference_ctrl
		total_ctrl_boxes - total_boxes
	end

	def display_difference_ctrl
		if total_ctrl_boxes == 0
			I18n.t('return.not_controlled_yet')
		else
			if difference_ctrl == 0
				I18n.t('return.no_difference_ctrl')
			elsif difference_ctrl >= 0
				I18n.t('return.positive_difference_ctrl', :difference => difference_ctrl)
			elsif difference_ctrl <= 0
				I18n.t('return.negative_difference_ctrl', :difference => (0 - difference_ctrl))
			end
		end
	end

end