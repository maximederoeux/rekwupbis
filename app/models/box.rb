class Box < ActiveRecord::Base
	
  has_many :boxdetails
  has_many :articles, through: :boxdetails
  
  has_many :offer_boxes
  has_many :offers, through: :offer_boxes

  has_many :return_details

  has_many :parcels

  scope :closed, lambda {where(:box_is_full => true)}
  scope :is_empty, lambda {where(:is_empty => true)}
  scope :is_kpt, lambda {where(:is_kpt => true)}
  scope :is_rekwup, lambda {where(:is_rekwup => true)}
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
  scope :is_bigbox, lambda {where(:bigbox => true)}
  scope :is_smallbox, lambda {where(:smallbox => true)}
  scope :is_mixed, lambda {where(:mixed => true)}
  scope :is_regular, lambda {where(:box_regular => true)}


	def automatic
      boxdetails.create(:box_id => id, :article_id => Article.is_top.first.id, :box_article_quantity => "1")
    if bigbox
      boxdetails.create(:box_id => id, :article_id => Article.is_big_box.first.id, :box_article_quantity => "1")
    elsif smallbox
      boxdetails.create(:box_id => id, :article_id => Article.is_small_box.first.id, :box_article_quantity => "1")
    end
	end

  def weight
    weight = 0
    self.boxdetails.each do |boxdetail|
    weight += boxdetail.weight
    end
    weight
  end

end
