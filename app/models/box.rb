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
    self.boxdetails.find_each do |boxdetail|
    weight += boxdetail.weight
    end
    weight
  end

  def type
    if box_regular
      I18n.t("box.box_regular")
    elsif mixed
      I18n.t("box.mixed")
    elsif is_empty
      I18n.t("box.is_empty")
    end   
  end

  def size
    if bigbox
      I18n.t("box.bigbox")
    elsif smallbox
      I18n.t("box.smallbox")      
    end
  end

  def cup_type
    if is_cc
      I18n.t("article.is_cc")
    elsif is_ep
      I18n.t("article.is_ep")
    elsif is_eco
      I18n.t("article.is_eco")
    elsif is_wine
      I18n.t("article.is_wine")
    elsif is_cava
      I18n.t("article.is_cava")
    elsif is_shot
      I18n.t("article.is_shot")
    end
  end

  def cup_content
    if is_twenty
      I18n.t("article.is_twenty")
    elsif is_twentyfive
      I18n.t("article.is_twentyfive")
    elsif is_forty
      I18n.t("article.is_forty")
    elsif is_fifty
      I18n.t("article.is_fifty")
    elsif is_litre
      I18n.t("article.is_litre")
    end
  end

  def cup_owner
    if is_rekwup
      I18n.t("article.rekwup_cup")
    elsif is_lln
      I18n.t("article.is_lln")
    elsif is_patro
      I18n.t("article.is_patro")
    elsif is_bep
      I18n.t("article.is_bep")
    end     
  end

  def sent_boxes(offer)
    offer.sent_boxes(self)
  end

  def is_big_box
    bigbox == true   
  end

  def is_small_box
    smallbox == true    
  end
end
