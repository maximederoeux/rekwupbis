class Article < ActiveRecord::Base
	
	has_many :boxdetails
	has_many :boxes, through: :boxdetails

	has_many :prices
	has_many :offer_articles
	has_many :sorting_details

	scope :not_washable, lambda {where.not(:is_washable => true)}
	scope :washable, lambda {where(:is_washable => true)}
	scope :is_cup, lambda {where(:is_cup => true)}
	scope :is_rekwup, lambda {where(:rekwup_cup => true)}
	scope :is_lln, lambda {where(:is_lln => true)}
	scope :is_bep, lambda {where(:is_bep => true)}
	scope :is_patro, lambda {where(:is_patro => true)}
	scope :is_twenty, lambda {where(:is_twenty => true)}
	scope :is_twentyfive, lambda {where(:is_twentyfive => true)}
	scope :is_forty, lambda {where(:is_forty => true)}
	scope :is_fifty, lambda {where(:is_fifty => true)}
	scope :is_litre, lambda {where(:is_litre => true)}
	scope :is_cc, lambda {where(:is_cc => true)}
	scope :is_ep, lambda {where(:is_ep => true)}
	scope :is_eco, lambda {where(:is_eco => true)}
	scope :is_wine, lambda {where(:is_wine => true)}
	scope :is_cava, lambda {where(:is_cava => true)}
	scope :is_shot, lambda {where(:is_shot => true)}
	scope :is_transport, lambda {where(:transport => true)}
	scope :is_big_box, lambda {where(:is_big_box => true)}
	scope :is_small_box, lambda {where(:is_small_box => true)}
	scope :is_top, lambda {where(:is_top => true)}
	scope :is_palette, lambda {where(:is_palette => true)}
	scope :is_empty, lambda {where(:is_empty => true)}
	scope :is_corona, lambda {where(:is_corona => true)}


	def full_name
		"#{article_name}"
	end



end
